package lib 
{
	import flash.display.Shape;
	import flash.display.MovieClip;
	import com.greensock.*; 
	
	public class BackEff extends MovieClip
	{
		
		public function BackEff() 
		{
			for (var i:int = 0; i < 60; i++) {
				tweenDot(getNewDot(), getRandom(0, 3));
			}
		}

		private function tweenDot(dot:Shape, delay:Number):void {
			dot.x = 172;
			dot.y = 160;
			TweenLite.to(dot, 3, {physics2D:{velocity:getRandom(80, 380), angle:getRandom(245, 295), gravity:400}, delay:delay, onComplete:tweenDot, onCompleteParams:[dot, 0]});
		}

		private function getNewDot():Shape {
			var s:Shape = new Shape();
			var green:uint = 0 | int(getRandom(80, 256)) << 8 | 0;
			s.graphics.beginFill(green, 1);
			s.graphics.drawCircle(0, 0, Math.random() * 8 + 5);
			s.graphics.endFill();
			this.addChild(s);
			return s;
		}

		private function getRandom(min:Number, max:Number):Number {
			return min + (Math.random() * (max - min));
		}
		
	}

}