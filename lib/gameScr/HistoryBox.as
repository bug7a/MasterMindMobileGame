package lib.gameScr {
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.utils.*;
	
	import lib.Global;
	import lib.Config;
	
	
	public class HistoryBox extends MovieClip {
		
		public var redLine:MovieClip; //turnLimit çizgisi
		private var _added:uint; //kaçıncı sırada kaldığı
		public var lines:Array; //satırlar

		public function HistoryBox() {

		}
		
		public function create() {
			_clear();
			
			//yeni oluşturulduğunda en baştan başla.
			_added = 0;
			lines = new Array();
			redLine.y = 110 + (21 * (Global.turnLimit - 1));
			
			_createLine(0);
			refresh();
		}
		
		private function _clear():void {
			//sadece sonradan eklenenleri sil.
			while (this.numChildren > 8) {
				this.removeChildAt(8);
			}
		}
		
		private function _createLine($num:int):void {
			//tablodaki bir satır.
			var __historyLine:MovieClip;
			
			__historyLine = new HistoryLine() as MovieClip;
			__historyLine.x = 0;
			__historyLine.y = 89 + (21 * $num);
			//satır numarası 1->..
			__historyLine.lineTxt.text = ($num + 1).toString();
			__historyLine.alpha = 0;
			addChild(__historyLine);
			//listeye ekle.
			lines.push(__historyLine);
			//alanları temizle.
			lines[$num].color1Txt.text = "";
			lines[$num].color2Txt.text = "";
			lines[$num].shapeTxt.text = "";
			//gel.
			TweenLite.to(__historyLine, 0.5, { alpha:1, ease:Bounce.easeOut } );
		}
		
		public function refresh() {

			//kaldığı yerden en son eklenen satıra kadar güncelle. ve bir boş satır ekle.
			for (var i:uint = _added; i < Global.dataHistory.length + 1; i++) {
				
				//bu satır daha önce eklenmemiş ise veya eğer ilk satırsa ise ekle.
				if (i != _added) {
					//limite geldiğinde bir sonraki satırı ekleme.
					if (Global.dataHistory.length < Global.turnLimit ) {
						//satır nesnesi.
						_createLine(i);
					}
				}
				
				//dataHistori kayıtları bittiğinde boş geç.
				if ( i < Global.dataHistory.length ) {
					//bilgileri satırlara yaz.
					lines[i].color1Txt.text = Global.statHistory[i].color1Num;
					lines[i].color2Txt.text = Global.statHistory[i].color2Num;
					lines[i].shapeTxt.text = Global.statHistory[i].shapeNum;
					
					//seçimi sekil ve renk olarak satıra ekle.
					for ( var j:uint = 0; j < Global.placeLimit; j++) {
						
						var __shape:Object = getDefinitionByName("Color" + Config.shapeList[Global.dataHistory[i][j].shapeID].name);
						var __colorObj:MovieClip = new __shape as MovieClip;
						var __colorTransform:ColorTransform = new ColorTransform();
						
						__colorTransform.color = Config.colorList[Global.dataHistory[i][j].colorID].code;
						__colorObj.transform.colorTransform = __colorTransform;
						lines[i].miniColorsArea.addChild(__colorObj);
						__colorObj.x = 13 * j;
					}
				}
				
				//eklenen satırı güncelle.
				_added = i;
			}
		}
	}
	
}
