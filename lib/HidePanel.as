package lib 
{
	
	import flash.display.MovieClip;
	import com.greensock.*;
	import com.greensock.easing.*;

	public class HidePanel extends MovieClip
	{
		
		public static var back:MovieClip;
		private static var _addedStage:MovieClip;
		
		public function HidePanel() 
		{

		}
		
		public static function Run($movie:MovieClip = null) {
			
			if (back == null) back = new Background() as MovieClip;
			if ( $movie == null) {
				TweenLite.to(back, 1, { visible:false, alpha:0, onComplete:_remove} );
			}else {
				_remove();
				back.alpha = 0;
				back.visible = true;
				$movie.addChild(back);
				_addedStage = $movie;
				TweenLite.to(back, 1, { alpha:.8} );
			}
		}
		
		private static function _remove():void
		{
			if (_addedStage != null) 
			{
			   _addedStage.removeChild(back);
			   _addedStage = null;
			}
		}

	}

}