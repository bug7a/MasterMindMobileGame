package lib.gameScr 
{

	public class GameLib 
	{
		
		import lib.Global;
		import lib.Config;
		import lib.GlobalLib;
		
		public function GameLib() 
		{
			
		}
		
		public static function clearDisplayColor():void {
			
			//tüm place lerin rengini sil.
			for (var i:uint = 0; i < Global.placeLimit; i++ ) {
				Global.gameDataP2[i].colorID = 0;
			}
			
		}
		
		public static function startNewGame():void {
			
					Global.gameTime = 0;
					
					Global.gameDiffuculty = Config.settings[0].difficulty;
					
					Global.gameDiffucultyName = Config.difficultyList[Global.gameDiffuculty].name;
					Global.colorLimit = Config.difficultyList[Global.gameDiffuculty].colorLimit;
					Global.shapeLimit = Config.difficultyList[Global.gameDiffuculty].shapeLimit;
					Global.placeLimit = Config.difficultyList[Global.gameDiffuculty].placeLimit;
					Global.turnLimit = Config.difficultyList[Global.gameDiffuculty].turnLimit;
					Global.gameScore = Config.difficultyList[Global.gameDiffuculty].score;
					
					Global.turnNum = 0;
			
					//birinci kullanıcı değişkenini oluştur.
					Global.gameDataP1 = new Array();
					//kullanılan değişkeni oluştur.
					Global.gameDataP2 = new Array();
					
					//oyuncunun bulması için bir olasılık belirle.
					for (var i:uint = 0; i <= Global.placeLimit - 1; i++ ) {
						
						var __diffrent:Boolean = false;
						var __shapeID:uint;
						var __colorID:uint;
						
						while (!__diffrent) {
							
							__shapeID = int(Math.random()*Global.shapeLimit) + 1;
							__colorID = int(Math.random()*Global.colorLimit) + 1;
							
							for (var j:uint = 0; j < Global.gameDataP1.length; j++) {
								__diffrent = true;
								if (__colorID == Global.gameDataP1[j].colorID) {
									__diffrent = false;
									break;
								}
							}
							
							if (Global.gameDataP1.length == 0) break;
						}
						
						Global.gameDataP1.push( { shapeID:__shapeID, colorID:__colorID } );

						//trace("colorID: " + Global.gameDataP1[i].colorID + ", shapeID: " + Global.gameDataP1[i].shapeID );

						Global.gameDataP2.push( { shapeID:0, colorID:0 } );
					}
					//bunları ilgili box ların içinde create functionuna koy.
					
					Global.dataHistory = new __AS3__.vec.Vector.<Array>();
					Global.statHistory = new Array();
		}
		
		public static function turnGame():Boolean {
			
			var __color1:uint = 0;
			var __color2:uint = 0;
			var __shape:uint = 0;
			
			var __bool:Boolean = false;
				
			for (var i:uint = 0; i < Global.placeLimit; i++) {
				if (Global.gameDataP2[i].shapeID == Global.gameDataP1[i].shapeID) {
					__shape++;
				}
				if (Global.gameDataP2[i].colorID == Global.gameDataP1[i].colorID) {
					__color1++;
				}else {
					for (var j:uint = 0; j < Global.placeLimit; j++) {
						if (Global.gameDataP2[i].colorID == Global.gameDataP1[j].colorID) {
							__color2++;
							break;
						}
					}
				}
			}
			
			Global.turnNum++;
			
			if (__color1 == Global.placeLimit && __shape == Global.placeLimit) {
				trace("you win");
				__bool = true;
			}
			
			Global.dataHistory.push(GlobalLib.cloneObject(Global.gameDataP2));
			Global.statHistory.push( { color1Num:__color1, color2Num:__color2, shapeNum:__shape } );
			
			return __bool;
		}
		
		public static function getTrue():void {
			Global.gameDataP2 = GlobalLib.cloneObject(Global.gameDataP1);
		}
		
		//public static function isWon():Boolean {
			//var __bool:Boolean = false;
			//if(
		//}
		
		public static function checkTurnBtn():Boolean {
			
			var __turn:Boolean = true;
			
			for ( var i:uint = 0; i < Global.dataHistory.length; i++) {
				var __turnNum:uint = 0;
				for ( var j:uint = 0; j < Global.placeLimit; j++) {
					//trace("1.color: " + Global.dataHistory[i][j].colorID);
					//trace("2.gameColor: " + Global.gameDataP2[j].colorID);
					if (Global.dataHistory[i][j].colorID == Global.gameDataP2[j].colorID && 
					    Global.dataHistory[i][j].shapeID == Global.gameDataP2[j].shapeID) {
						__turnNum++;
						if (__turnNum == Global.placeLimit) {
							//trace("Find: " + i + ", place:" + j);
							__turn = false;
							break;
						}
					}
				}
			}
			
			for ( var k:uint = 0; k < Global.placeLimit; k++) {
				if (Global.gameDataP2[k].colorID == 0 || Global.gameDataP2[k].shapeID == 0) {
						//trace("Find: " + k + ", Boş");
						__turn = false;
						break;
				}
			}
			
			return __turn;
		}
		
		public static function checkClearBtn():Boolean {
			
			var __clear:Boolean = false;
			
			for ( var k:uint = 0; k < Global.placeLimit; k++) {
				if (Global.gameDataP2[k].colorID != 0) {
						__clear = true;
					}
			}
			
			return __clear;
		}
		
	}

}