package lib 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	import flash.utils.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.flafolder.ui.ButtonA1;
	import lib.startScr.*;
	import lib.SoundLib;
	
	public class StartScr extends MovieClip
	{
		
		private var _menu:MovieClip;
		private var _buttons:Array = new Array();
		
		private const _resumeName = "Resume"; 
		private const _buttonList:Array = new Array({name:"Play", url:"" },
												  {name:"Help", url:"" },
												  {name:"Scores", url:"http://www.flafolder.com/games/new.mastermind/scores/" },
												  {name:"Settings", url:"" },
												  {name:"Games", url:"http://www.flafolder.com/games/" },
												  {name:"Quit", url:"" } );

		public var infoBox:InfoBox = new InfoBox();
		public var settingsDlg:SettingsDlg = new SettingsDlg();
		
		public function StartScr() 
		{
			alpha = 0;
			
			_createMenu();
			addChild(infoBox);
			addChild(settingsDlg);
			
			_menu.addEventListener(MouseEvent.CLICK, _menuClicked);
			infoBtn.addEventListener(MouseEvent.CLICK, _openInfo);
			
			infoBox.addEventListener("Close", _closeInfo);
			settingsDlg.addEventListener("Close", _closeSettings);
			
		}
		
		//play buttonunun adını değiştir.
		public function changeButtonName($bool:Boolean) {
			if ($bool) {
				_buttons[0].label = _resumeName;
			}else {
				_buttons[0].label = _buttonList[0].name;
			}
		}
		
		//close info dlg.
		private function _closeInfo(e:Event):void {
			HidePanel.Run();
			TweenLite.to(infoBox, .5, { visible:false, alpha:0, y: -1 * infoBox.height } );
		}
		
		//open info dlg.
		private function _openInfo(e:Event):void {
			HidePanel.Run(this);
			setChildIndex(infoBox, this.numChildren - 1);
			var __y:uint = int((HidePanel.back.height - infoBox.height) / 2);
			var __x:uint = int((HidePanel.back.width - infoBox.width) / 2);
			infoBox.y = 0;
			infoBox.x = __x;
			infoBox.visible = true;
			TweenLite.to(infoBox, 1, { alpha:1, x:__x, y:__y, ease:Elastic.easeOut } );
		}
		
		private function _closeSettings(e:Event):void {
			HidePanel.Run();
			TweenLite.to(settingsDlg, .5, { visible:false, alpha:0, y: -1 * settingsDlg.height } );
		}
		
		private function _openSettings():void {
			HidePanel.Run(this);
			setChildIndex(settingsDlg, this.numChildren - 1);
			var __y:uint = int((HidePanel.back.height - settingsDlg.height) / 2);
			var __x:uint = int((HidePanel.back.width - settingsDlg.width) / 2);
			settingsDlg.y = 0;
			settingsDlg.x = __x;
			settingsDlg.visible = true;
			settingsDlg.refresh();
			TweenLite.to(settingsDlg, 1, { alpha:1, x:__x, y:__y, ease:Elastic.easeOut } );
		}
		
		//menu clicked.
		private function _menuClicked(e:MouseEvent):void {
			
			switch(e.target.parent.parent.name) {
				case "0":
					dispatchEvent(new Event("Play"));
					break;
				case "1":
					dispatchEvent(new Event("Help"));
					break;
				case "2":
					dispatchEvent(new Event("Scores"));
					break;
				case "3":
					dispatchEvent(new Event("Settings"));
					_openSettings();
					break;
				case "4":
					dispatchEvent(new Event("More"));
					break;
				case "5":
					dispatchEvent(new Event("Quit"));
					break;
				default:
					trace("diğer");
					break;
			}
			
		}
		
		//menuyü oluştur.
		private function _createMenu():void {
			
			var __button:ButtonA1;
			var __line:StartMenuLine;
			var __icon:Object;
			_menu = new MovieClip();
			
			var iTo:int = _buttonList.length - 1;
			
			//web tabanlı çalışırsa menuden çıkışı çıkart.
			if (Config.platform == "web") iTo--;
			
			for ( var i = 0; i <= iTo; i++) {
				
					__button = new ButtonA1();
					
					_buttons.push(__button);
					_menu.addChild(__button);
					__button.name = i;
					__button.label = _buttonList[i].name;
					__button.labelAlign = TextFormatAlign.LEFT;
					__button.fontSize = 35;
					__button.antiAlias = ButtonA1.ANTIALIAS.ADVANCED;
					__button.leftSpace = 14;
					__button.labelLeftSpace = 4;
					__button.effect = ButtonA1.EFFECT.MOVE_TO_UP;
					__button.setStyle(ButtonA1.STYLE.SKIN, ButtonA1_minimal );
					
					__button.url = _buttonList[i].url;
					//__button.setStyle(ButtonA1.STYLE.OVER_SOUND, SoundLib.over );
					//__button.setStyle(ButtonA1.STYLE.DOWN_SOUND, SoundLib.buttonClick );
					
					__icon = getDefinitionByName("M" + (i + 1).toString() + "Icn");
					__button.setStyle(ButtonA1.STYLE.LEFT_ICON, __icon );
					
					__button.x = 0;
					__button.y = 68 * i;
					
					__button.width = 300;
					__button.height = 60;
					
					__line = new StartMenuLine();
					if(i != iTo) _menu.addChild(__line);
					
					__line.x = 0;
					__line.y = __button.y + __button.height + 4;
					
			}
			
			addChild(_menu);
			_menu.x = int((this.width - _menu.width) / 2);
			_menu.y = int((this.height - _menu.height) / 2);
		}
		
	}

}