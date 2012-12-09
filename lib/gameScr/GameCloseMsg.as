package lib.gameScr 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.flafolder.ui.ButtonA1;
	import flash.ui.Mouse;
	
	public class GameCloseMsg extends MovieClip
	{
		public var backBtn:ButtonA1;
		public var closeBtn:ButtonA1;
		public var pauseBtn:ButtonA1;
		
		public function GameCloseMsg() 
		{
			visible = false;
			
			backBtn.antiAlias = ButtonA1.ANTIALIAS.ADVANCED;
			closeBtn.antiAlias = ButtonA1.ANTIALIAS.ADVANCED;
			pauseBtn.antiAlias = ButtonA1.ANTIALIAS.ADVANCED;
			
			pauseBtn.setStyle(ButtonA1.STYLE.SKIN, ButtonA1_defaultBlue );
			
			//closeBtn.setStyle(ButtonA1.STYLE.LEFT_ICON, CloseGreyIcn );
			//pauseBtn.setStyle(ButtonA1.STYLE.LEFT_ICON, PauseIcn );
			
			backBtn.addEventListener(MouseEvent.CLICK, _backToGame);
			closeBtn.addEventListener(MouseEvent.CLICK, _closeGame);
			pauseBtn.addEventListener(MouseEvent.CLICK, _pauseGame);
					
			//__button.setStyle(ButtonA1.STYLE.OVER_SOUND, SoundLib.over );
			//__button.setStyle(ButtonA1.STYLE.DOWN_SOUND, SoundLib.buttonClick );

		}
		
		private function _closeGame(e:MouseEvent):void {
			dispatchEvent(new Event("CloseGame"));
			dispatchEvent(new Event("Close"));
		}
		
		private function _pauseGame(e:MouseEvent):void {
			dispatchEvent(new Event("PauseGame"));
			dispatchEvent(new Event("Close"));
		}
		
		private function _backToGame(e:MouseEvent):void {
			dispatchEvent(new Event("Close"));
		}
		
	}

}