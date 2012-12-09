package lib.gameScr {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import lib.Global;
	import lib.Config;
	import lib.GameEvent;
	
	public class ColorBox extends MovieClip {
		
		public var colorAreas:Array;
		public var whiteDots:Array;
		public var colorDot:MovieClip;
		
		public function ColorBox() {
			//code
		}
		
		public function show($visible:Boolean = true) {
			this.alpha = int($visible);
			refresh();
		}
		
		/*
		 * colorBoxın içindeki herşeyi siler.
		 */
		private function _clear():void {
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
		}
		
		/*
		 * colorBoxın içindeki herşeyi silip yeniden oluşturur.
		 */
		public function create():void {
			
			_clear();
			
			colorAreas = new Array();
			whiteDots = new Array();
			
			var __colorArea:MovieClip;
			var __colorDot:MovieClip;
			
			for (var i:uint = 1; i <= Global.colorLimit; i++ ) {
				
				__colorArea = new ColorArea();
				addChild(__colorArea);
				__colorArea.colorNumTxt.text = (Global.colorLimit > 8) ? i : "";
				__colorArea.x = 14;
				__colorArea.y = (i - 1) * 16;
				
				var __colorTransform:ColorTransform = new ColorTransform();
				__colorTransform.color = Config.colorList[i].code;
				__colorArea.colorObj.transform.colorTransform = __colorTransform;
				colorAreas.push(__colorArea);
			}
			
			for (var j:uint = 0; j <= Global.placeLimit - 1; j++) { 
				var __whiteDot:MovieClip = new WhiteDot();
				addChild(__whiteDot);
				__whiteDot.alpha = 0;
				whiteDots.push(__whiteDot);
				}
			
			colorDot = new ColorDot();
			colorDot.alpha = 0;
			addChild(colorDot);
			
			alpha = 0;
			
			dispatchEvent(new Event(GameEvent.ON_CREATED));
			
		}
		
		/*
		 * seçilmiş renklerin noktalarını yeniler.
		 */
		public function refresh():void {
			
			var __whiteDotNum:uint = 0;
			colorDot.alpha = 0;
			
			for (var i:uint = 0; i <= Global.placeLimit - 1; i++) {
				
				var __colorID:int = Global.gameDataP2[i].colorID;
				var __dotY:int = 3 + (int(__colorID) - 1) * 16;
				whiteDots[i].alpha = 0;
				
				if (__colorID != 0) {
					if (Global.selectedPlace != i) {
						whiteDots[__whiteDotNum].alpha = 1;
						whiteDots[__whiteDotNum].x = 0;
						whiteDots[__whiteDotNum].y = __dotY;
						__whiteDotNum++;
					}else {
						colorDot.alpha = 1;
						colorDot.x = 0;
						colorDot.y = __dotY;
					}
				}
			}
		}
	}
	
}
