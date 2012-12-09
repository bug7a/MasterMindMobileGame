package lib 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.flafolder.ui.ButtonA1;
	
	public class HelpScr extends MovieClip
	{
	
		public var closeBtn:ButtonA1;	
		
		public function HelpScr() 
		{
			alpha = 0;
			closeBtn.addEventListener(MouseEvent.CLICK, _mouseClicked);
		}
		
		private function _mouseClicked(e:MouseEvent):void {
			dispatchEvent(new Event("Close"));
		}
		
	}

}