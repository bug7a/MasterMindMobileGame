package lib.gameScr 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.flafolder.ui.ButtonA1;
	
	public class GameOverMsg  extends MovieClip
	{
		
		public var closeBtn:ButtonA1;
		public var startBtn:ButtonA1;
		
		public function GameOverMsg() 
		{
			this.visible = false;
			
			startBtn.antiAlias = ButtonA1.ANTIALIAS.ADVANCED;
			closeBtn.antiAlias = ButtonA1.ANTIALIAS.ADVANCED;
			
			startBtn.setStyle(ButtonA1.STYLE.SKIN, ButtonA1_defaultBlue );
			
			startBtn.addEventListener(MouseEvent.CLICK, _startGame);
			closeBtn.addEventListener(MouseEvent.CLICK, _closeGame);

		}
		
		private function _closeGame(e:MouseEvent):void {
			dispatchEvent(new Event("CloseGame"));
			dispatchEvent(new Event("Close"));
		}
		
		private function _startGame(e:MouseEvent):void {
			dispatchEvent(new Event("StartGame"));
			dispatchEvent(new Event("Close"));
		}
	}
}