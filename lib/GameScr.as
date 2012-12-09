package lib {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	import lib.gameScr.GameCloseMsg;
	
	import lib.GameEvent;
	import lib.HidePanel;
	import lib.gameScr.GameLib;
	import lib.Global;
	import lib.Config;
	import com.flafolder.ui.ButtonA1;
	
	public class GameScr extends MovieClip {
		
		public var displayBox:MovieClip;
		public var colorBox:MovieClip;
		public var shapeBox:MovieClip;
		public var historyBox:MovieClip;
		public var displayBackFront:MovieClip;
		public var whiteBackground:MovieClip;
		
		public var closeBtn:MovieClip;
		public var refreshBtn:ButtonA1;
		public var clearBtn:ButtonA1;
		public var turnBtn:ButtonA1;
		
		private var _timer:Timer = new Timer(1000);
		private var _count:Timer = new Timer(1600);
		private var _colorBoxX:int;
		private var _shapeBoxY:int;
		
		private var _closeMsg:GameCloseMsg = new GameCloseMsg();
		public var gameWinMsg:MovieClip;
		public var gameOverMsg:MovieClip;
		
		public function GameScr() {
			
			clearBtn.setStyle(ButtonA1.STYLE.SKIN, ButtonA1_minimal);
			turnBtn.setStyle(ButtonA1.STYLE.SKIN, ButtonA1_minimal);
			
			//pauseBtn.setStyle(ButtonA1.STYLE.LEFT_ICON, PauseIcn);
			clearBtn.setStyle(ButtonA1.STYLE.LEFT_ICON, ClearIcn);
			turnBtn.setStyle(ButtonA1.STYLE.LEFT_ICON, TurnIcn);
			
			clearBtn.effect = 
			turnBtn.effect  = ButtonA1.EFFECT.NO_EFFECT;
			
			displayBox.addEventListener(GameEvent.PLACE_ON_SELECTED, _placeSelected);
			clearBtn.addEventListener(MouseEvent.CLICK, _clearBtnClicked);
			turnBtn.addEventListener(MouseEvent.CLICK, _turnBtnClicked);
			//addEventListener(Event.ACTIVATE, _refreshLayout);
			closeBtn.addEventListener(MouseEvent.CLICK, _openCloseMsg);
			_timer.addEventListener(TimerEvent.TIMER, _timerDo);
			_count.addEventListener(TimerEvent.TIMER, _countDo);
			
			addChild(_closeMsg);
			
			_closeMsg.addEventListener("Close", _closeCloseMsg);
			_closeMsg.addEventListener("CloseGame", _closeGame);
			_closeMsg.addEventListener("PauseGame", _pauseGame);
			
			gameWinMsg.addEventListener("Close", _closeWinMsg);
			gameWinMsg.addEventListener("CloseGame", _closeGame);
			gameWinMsg.addEventListener("StartGame", _nextLevel);
			gameWinMsg.addEventListener("SaveScore", _closeGame);
			
			gameOverMsg.addEventListener("Close", _closeOverMsg);
			gameOverMsg.addEventListener("CloseGame", _closeGame);
			gameOverMsg.addEventListener("StartGame", _restart);
			
			//whiteBackground.visible = false;
			gameOverMsg.visible = false;
			gameWinMsg.visible = false;
			mouseCursor.visible = false;
			
			alpha = 0;
			
			//this.width = 320;
			//this.height = 480;

		}
		
		private function _restart(e:Event = null) {
			startGame();
		}
		
		private function _nextLevel(e:Event = null) {
			if(int(Config.settings[0].difficulty) < (Config.difficultyList.length - 1)) {
				Config.settings[0].difficulty++;
			}
			startGame();
		}

		private function _timerDo(e:TimerEvent):void{
			 Global.gameTime += 1;
			_refreshScore();
		}
		
		private function _countDo(e:TimerEvent):void{
			//code
			countBox.countTxt.text = String(3 - _count.currentCount);
			if (_count.currentCount == 3) {
				TweenLite.to(countBox, .5, { visible:false, alpha:0, y: -1 * countBox.height } );
				TweenLite.to(whiteBackground, 1, { visible:false, alpha:0 } );
				_timer.start();
				_count.stop();
				_count.reset();
			}
		}
		
		private function _refreshScore():void {
			 var __timeType = (Global.gameTime >= 3600) ? 2 : 1;
			 timeTxt.text = GlobalLib.formatTime(Number(Global.gameTime), __timeType);
			 scoreTxt.text = (int(Global.gameScore - Global.gameTime - GlobalLib.getStrata(2, Global.turnNum))).toString();
			 Global.currentScore = int(scoreTxt.text) <= 0 ? 0 : int(scoreTxt.text);
			 if (Global.currentScore <= 0) {
				scoreTxt.text = "0";
				_timer.stop();
				
				_gameover();
			 }
		}
		
		private function _closeGame(e:Event):void {
				Global.game = false;
				_timer.stop();
				dispatchEvent(new Event("Close"));
			}
		
		private function _pauseGame(e:Event):void {
				Global.game = true;
				_timer.stop();
				dispatchEvent(new Event("Close"));
		}
		
		private function _clearBtnClicked(e:MouseEvent = null):void {

			GameLib.clearDisplayColor();
			
			displayBox.refresh();
			_checkTurnBtn();
			_checkCleanBtn();

		}
		
		public function startGame($newGame:Boolean = true) {
			
			SoundLib.stopMusic();
			
			whiteBackground.visible = true;
			whiteBackground.alpha = 1;
			
			var __y:uint = int((whiteBackground.height - countBox.height) / 2);
			var __x:uint = int((whiteBackground.width - countBox.width) / 2);
			countBox.y = 0;
			countBox.x = __x;
			countBox.alpha = 0;
			countBox.visible = true;
			countBox.countTxt.text = "3";
			TweenLite.to(countBox, 1, { alpha:1, x:__x, y:__y, ease:Elastic.easeOut } );

			Global.game = true;
			
			if ($newGame) {
				GameLib.startNewGame();
				timeTxt.text = "0:00";
			}
			
			scoreTxt.text = String(Global.gameScore);
				
			//whiteBackground.visible = false;
			//gameOverMsg.visible = false;
			//gameWinMsg.visible = false;

			_count.start();

			displayBox.create();
			colorBox.create();
			shapeBox.create();
			historyBox.create();
			//historyBox.refresh();
			
			difficultyTxt.text = "Difficulty: " + Global.gameDiffucultyName;
			
			_checkTurnBtn();
			_checkCleanBtn();
			
			_refreshLayout();
			
		}
		
		private function _win(e:Event = null):void {
			SoundLib.won.play(0,0,SoundLib.soundTransform);
			TweenLite.to(clearBtn, .5, { x:clearBtn.x - 10, alpha:0, ease:Circ.easeOut } );
			gameWinMsg.alpha = 0;
			gameWinMsg.visible = true;
			if(int(Config.settings[0].difficulty) < int(Config.difficultyList.length) - 1 ) {
				gameWinMsg.startBtn.label = "Next Level";
			}else {
				gameWinMsg.startBtn.label = "Restart";
			}
			TweenLite.to(gameWinMsg, 1, { alpha:1 } );
			whiteBackground.alpha = 0;
			whiteBackground.visible = true;
			TweenLite.to(whiteBackground, 1, { alpha:1 } );
		}
		
		private function _closeWinMsg(e:Event = null):void {
			TweenLite.to(gameWinMsg, 1, { visible:false, alpha:0 } );
			TweenLite.to(whiteBackground, 1, { visible:false, alpha:0 } );
		}
		
		private function _closeOverMsg(e:Event = null):void {
			TweenLite.to(gameOverMsg, 1, { visible:false, alpha:0 } );
			TweenLite.to(whiteBackground, 1, { visible:false, alpha:0 } );
		}
		
		private function _gameover(e:Event = null):void {
			SoundLib.gameover.play(0,0,SoundLib.soundTransform);
			_mouseUped();
			_closeCloseMsg();
			TweenLite.to(clearBtn, .5, { x:clearBtn.x - 10, alpha:0, ease:Circ.easeOut } );
			TweenLite.to(turnBtn, .5, { y:624, alpha:0, ease:Circ.easeOut } );
			GameLib.getTrue();
			displayBox.refresh();
			gameOverMsg.alpha = 0;
			gameOverMsg.visible = true;
			TweenLite.to(gameOverMsg, 1, { alpha:1 } );
			whiteBackground.alpha = 0;
			whiteBackground.visible = true;
			TweenLite.to(whiteBackground, 1, { alpha:1 } );
		}
		
		private function _closeCloseMsg(e:Event = null):void {
			HidePanel.Run();
			TweenLite.to(_closeMsg, .5, { visible:false, alpha:0, y: -1 * _closeMsg.height } );
		}
		
		private function _openCloseMsg(e:MouseEvent):void {
			SoundLib.notice.play(0,0,SoundLib.soundTransform);
			HidePanel.Run(this);
			setChildIndex(_closeMsg, this.numChildren - 1);
			var __y:uint = int((HidePanel.back.height - _closeMsg.height) / 2);
			var __x:uint = int((HidePanel.back.width - _closeMsg.width) / 2);
			_closeMsg.y = 0;
			_closeMsg.x = __x;
			_closeMsg.visible = true;
			TweenLite.to(_closeMsg, 1, { alpha:1, x:__x, y:__y, ease:Elastic.easeOut } );
		}
		
		private function _checkCleanBtn($bool:int = 2):void {
			
			var __bool:Boolean = ($bool == 2) ? GameLib.checkClearBtn() : Boolean($bool);
			if (__bool) {
				if(clearBtn.alpha < 1) {
					clearBtn.x = _colorBoxX - 10;
					TweenLite.to(clearBtn, .5, { x:_colorBoxX, alpha:1, ease:Circ.easeOut } );
				}
			}else {
				if(clearBtn.alpha > 0)
				TweenLite.to(clearBtn, .5, { x:clearBtn.x - 10, alpha:0, ease:Circ.easeOut } );
			}
		}
		
		private function _checkTurnBtn():void {
			var __bool:Boolean = GameLib.checkTurnBtn();
			if (__bool) {
				TweenLite.to(turnBtn, .5, { y:634, alpha:1, ease:Circ.easeOut } );
			}else {
				TweenLite.to(turnBtn, .5, { y:624, alpha:0, ease:Circ.easeOut } );
			}
		}
		
		private function _turnBtnClicked(e:MouseEvent = null) {
				
			var __isWon:Boolean = GameLib.turnGame();
			
			historyBox.refresh();
			
			_checkTurnBtn();
			_checkCleanBtn();
			
			if (__isWon) {
				_timer.stop();
				_win();
			}else if (Global.turnNum == Global.turnLimit ) {
				_timer.stop();
				_gameover();
			}
		}
		
		private function _placeSelected(e:Event = null) {
			
				_checkCleanBtn(0);
				addEventListener(MouseEvent.MOUSE_UP, _mouseUped);
				addEventListener(MouseEvent.MOUSE_MOVE, _mouseMoved);
				
				mouseCursor.visible = true;
				mouseCursor.x = this.mouseX;
				mouseCursor.y = this.mouseY;
				
				colorBox.x = _colorBoxX - 10;
				shapeBox.y = _shapeBoxY + 10;
				TweenLite.to(colorBox, .5, { x:_colorBoxX, alpha:1, ease:Circ.easeOut } );
				colorBox.refresh();
				TweenLite.to(shapeBox, .5, { y:_shapeBoxY, alpha:1, ease:Circ.easeOut } );
				shapeBox.refresh();
			}
			
		private function _shapeChanged(e:Event = null) {
				
			}
		
		private function _mouseMoved(e:MouseEvent = null)  {
			
			displayBox.updateSelectedPlace();
			colorBox.refresh();
			shapeBox.refresh();

		}
		
		private function _mouseUped(e:MouseEvent = null):void {
			//Global.selectedPlace = null;
			//clearBtn.visible = true;
			_checkTurnBtn();
			_checkCleanBtn();
			removeEventListener(MouseEvent.MOUSE_UP, _mouseUped);
			removeEventListener(MouseEvent.MOUSE_MOVE, _mouseMoved);
			
			mouseCursor.visible = false;
			
			TweenLite.to(colorBox, .5, { x:colorBox.x - 10, alpha:0, ease:Circ.easeOut } );
			TweenLite.to(shapeBox, .5, { y:shapeBox.y + 10, alpha:0, ease:Circ.easeOut } );
			
		}
		
		private function _refreshLayout(e:Event = null) {
			
			displayBox.x = int(displayBackFront.x + ((displayBackFront.width - displayBox.width) / 2));
			displayBox.y = int(displayBackFront.y + ((displayBackFront.height - displayBox.height) / 2));
			colorBox.x = displayBox.x + 105;
			_colorBoxX = colorBox.x;
			colorBox.y = int(displayBox.y + ((displayBox.height - colorBox.height) / 2));
			clearBtn.x = colorBox.x;
			clearBtn.y = colorBox.y + int((colorBox.height - 40) / 2);
			shapeBox.y = displayBox.y - 45;
			shapeBox.x = int(displayBackFront.x + ((displayBackFront.width - shapeBox.width) / 2));
			_shapeBoxY = shapeBox.y;
			
		}
	}
	
}
