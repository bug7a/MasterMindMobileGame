package lib.gameScr {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.events.Event;
	import flash.utils.*;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import lib.Global;
	import lib.Config;
	import lib.GameEvent;
	import lib.SoundLib;
	
	public class DisplayBox extends MovieClip {
		
		private static const MOUSE_SPACE:int = 25;
		
		public var shapes:Array;
		private var _shapesType:Array;
		private var _lastMouseX:int;
		private var _lastMouseY:int;
		
		private var _oldShape:MovieClip;
		
		
		public function DisplayBox() {
			addEventListener(MouseEvent.MOUSE_DOWN, _mouseDowned);
		}
			
		private function _mouseDowned(e:MouseEvent = null):void {
			_lastMouseX = this.mouseX;
			_lastMouseY = this.mouseY;
			Global.selectedPlace = uint(e.target.parent.name);
			trace(e.target.parent.name);
			dispatchEvent(new Event(GameEvent.PLACE_ON_SELECTED));
		}
		
		//
		public function updateSelectedPlace():void {
				var __mouseYSpace:int = this.mouseY - _lastMouseY;
				var __mouseXSpace:int = this.mouseX - _lastMouseX;
				if (__mouseXSpace > MOUSE_SPACE || __mouseXSpace < (MOUSE_SPACE * -1)) {
					_changeSelectedShape(int(__mouseXSpace / MOUSE_SPACE))
				}
				//mouse hareketi 10 veya -10 ise rengi değiştir.
				if (__mouseYSpace > MOUSE_SPACE || __mouseYSpace < (MOUSE_SPACE * -1)) {
					_changeSelectedColor(int(__mouseYSpace / MOUSE_SPACE));
				}
			}
			
		private function _changeSelectedShape($num:int = 1) {
			_lastMouseX += $num * MOUSE_SPACE;
			var __wantedShape:int = uint(Global.gameDataP2[Global.selectedPlace].shapeID);
			__wantedShape += $num;
			//if (__wantedShape > Global.shapeLimit) __wantedShape = 1;
			//if (__wantedShape < 1) __wantedShape = Global.shapeLimit;
			if (__wantedShape > Global.shapeLimit) __wantedShape = Global.shapeLimit;
			if (__wantedShape < 1) __wantedShape = 1;
			
			//eğer farklı bir şekil isteniyorsa değiştir.
			if (_shapesType[Global.selectedPlace] != __wantedShape) {
				SoundLib.over.play(0,0,SoundLib.soundTransform);
				changeShape(__wantedShape, Global.selectedPlace);
			}
		}
			
		// 1: next color, -1 back color.
		//eğer renk başkası tarafından kullanıyorsa yöne göre bir sonraki renki seç.
		private function _changeSelectedColor($num:int = 1) {
				//tıklama noktasını güncelle.
				_lastMouseY += $num * MOUSE_SPACE;
				var __freeColor:Boolean = true;
				var __wantedColor:int = uint(Global.gameDataP2[Global.selectedPlace].colorID);
				var __quit:int;
				while (__freeColor) {
					__wantedColor = (__wantedColor != 0) ? __wantedColor + $num : $num;
					if (__wantedColor > Global.colorLimit) __wantedColor = 1;
					if (__wantedColor < 1) __wantedColor = Global.colorLimit;

					for (var i = 0; i <= Global.gameDataP2.length - 1; i++) {
						__freeColor = false;
						if (__wantedColor == Global.gameDataP2[i].colorID) {
							__freeColor = true;
							break;
						}
					}
					__quit++;
					if (__quit > 300) break;
				}
				//renk bulunmuş 
				if (__freeColor == false) {
					//güncelle.
					SoundLib.beep.play(0,0,SoundLib.soundTransform);
					changeColor(__wantedColor, Global.selectedPlace);
					}else {
						//Yeterli renk yok.
					}
			}
		
		/*
		 * içindeki herşeyi siler.
		 */
		private function _clear():void {
			//herşey silinene kadar sil.
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
		}
		
		/*
		 * displayBox içindeki herşeyi silip yeniden oluşturur.
		 */
		public function create():void {
			//tüm ekranı temizle
			_clear();
			//shapes değişkenini temizle.
			shapes = new Array();
			_shapesType = new Array();
			
			//tüm placelere shape koy.
			for (var i:uint = 0; i <= Global.placeLimit - 1; i++ ) {
				//değişkene boş bir mc yer aç.
				shapes.push(new MovieClip());
				_shapesType.push(0);
			}
			//display oluşturuldu.
			dispatchEvent(new Event(GameEvent.ON_CREATED));
			//renkleri al.
			refresh();
		}
		
		public function refresh():void {
			for (var i:uint = 0; i <= Global.placeLimit - 1; i++ ) {
				changeShape(Global.gameDataP2[i].shapeID, i);
			}
		}
		
		/*
		 * yani bir sekil oluştur
		 */
		private function changeShape($shapeID:uint, $placeNum:uint):void {
			
			//master shape i al.
			var __shape:Object = getDefinitionByName(Config.shapeList[$shapeID].name + "Shp");
			//if (contains(shapes[$placeNum])) removeChild(shapes[$placeNum]);
			if (contains(shapes[$placeNum])) {
				//eğer ekranda ise sil.
				//_oldShape = shapes[$placeNum];
				//TweenLite.to(_oldShape, .1, {x:-10, alpha:.5, ease:Circ.easeOut, onComplete:_remove});
				removeChild(shapes[$placeNum]);
			}
			//masterdan yeni bir clone oluştur.
			shapes[$placeNum] = new __shape as MovieClip;
			//shapetype yaz.
			_shapesType[$placeNum] = $shapeID;
			//ismini sıra numarası yap.
			shapes[$placeNum].name = $placeNum;
			//alpha
			//shapes[$placeNum].alpha = 0;
			//sahneye ekle.
			addChild(shapes[$placeNum]);
			//kordinatları ayarla.
			shapes[$placeNum].x = 0;
			shapes[$placeNum].y = $placeNum * 60;
			//en son eklenen en altta olarak ayarla.
			setChildIndex(shapes[$placeNum], (this.numChildren < Global.placeLimit) ? 0 : Global.placeLimit - $placeNum - 1);
			//oyun değişkenlerini güncelle.
			Global.gameDataP2[$placeNum].shapeID = $shapeID;
			//getir
			//TweenLite.to(shapes[$placeNum], .5, {alpha:1, ease:Circ.easeOut});
			//tekrar boya.
			changeColor(Global.gameDataP2[$placeNum].colorID, $placeNum);
		}
		
		private function _remove():void
		{
		   removeChild(_oldShape);
		}
		
		/*
		 * sırası verilen şekli id si verilen renke boya.
		 */ 
		public function changeColor($colorID:uint, $placeNum:uint):void {
				//renk nesnesi oluştur.
				var __colorTransform:ColorTransform = new ColorTransform();
				//rengini ayarla.
				__colorTransform.color = Config.colorList[$colorID].code;
				//shape in rengini ayarla.
				TweenMax.to(shapes[$placeNum].colorObj, .5, {colorTransform:{tint:Config.colorList[$colorID].code, tintAmount:1}});
				//shapes[$placeNum].colorObj.transform.colorTransform = __colorTransform;
				//değişkeni güncelle.
				Global.gameDataP2[$placeNum].colorID = $colorID;
		}
	}
	
}
