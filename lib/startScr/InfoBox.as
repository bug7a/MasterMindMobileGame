package lib.startScr 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class InfoBox  extends MovieClip
	{
		
		public function InfoBox() 
		{
			this.visible = false;
			closeBtn.addEventListener(MouseEvent.CLICK, _closeMe);
		}
		
		private function _closeMe(e:MouseEvent):void {
			dispatchEvent(new Event("Close"));
		}
		
	}

}