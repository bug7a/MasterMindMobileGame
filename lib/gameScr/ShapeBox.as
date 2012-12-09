package lib.gameScr {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.utils.*;
	
	import lib.Global;
	import lib.Config;
	import lib.GameEvent;
	
	public class ShapeBox extends MovieClip {
		
		public var shapes:Array;
		
		public function ShapeBox() {
			//code
		}
		
		//tüm nesneleri sil.
		private function _clear():void {
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
		}
		
		public function show($visible:Boolean = true) {
			this.alpha = int($visible);
			refresh();
		}
		
		public function create() {
			
			_clear();
			
			shapes = new Array();
						
			for (var i:uint = 1; i <= Global.shapeLimit; i++ ) {
				
				var __shape:Object = getDefinitionByName(Config.shapeList[i].name + "Shp");
				
				shapes.push(new __shape as MovieClip);
				addChild(shapes[i-1]);
				shapes[i-1].width = 26;
				shapes[i-1].height = 26;
				shapes[i-1].y = 0;
				shapes[i-1].x = 36 * (i-1);

			}
			
			alpha = 0;
			
			dispatchEvent(new Event(GameEvent.ON_CREATED));
			
		}
		
		public function refresh() {
			
			var __colorTransform:ColorTransform = new ColorTransform();
			
			for (var i:uint = 0; i <= Global.shapeLimit - 1; i++) {
				__colorTransform.color = (Global.gameDataP2[Global.selectedPlace].shapeID == (i + 1)) ? 0xFF6600 : 0xEEEEEE;
				shapes[i].colorObj.transform.colorTransform = __colorTransform;
			}
		}
	}
	
}
