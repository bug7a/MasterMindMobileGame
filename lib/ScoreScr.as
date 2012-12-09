package lib 
{
	import flash.display.MovieClip;
	
	public class ScoreScr extends MovieClip
	{
	
		//private var _board:Score = new Score();
		
        //public static const GAME_ID:String = "84993a1de4031cd8";
        //public static const AD_ID:String = "test";  // This is normally your GAME_ID

        public function ScoreScr():void
        {
			//MochiServices.connect("4b6b5dfba8fa564c", root);   
			
			//start();
        }
        
        public function openScoreBoard():void
        {
			//MochiServices.connect("c9bbc179cb97e846", root);
			
			//var o:Object = { n: [4, 6, 5, 0, 3, 10, 6, 5, 2, 4, 9, 0, 0, 8, 15, 6], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			//var boardID:String = o.f(0,"");
			//MochiScores.showLeaderboard({boardID: boardID});
			
			//MochiServices.connect( "c9bbc179cb97e846", this, onFailure );
//
			//var BOARD_O = { n: [4, 6, 5, 0, 3, 10, 6, 5, 2, 4, 9, 0, 0, 8, 15, 6], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			//var BOARD_ID = BOARD_O.f(0, "");
			//MochiScores.showLeaderboard({
				//boardID: BOARD_ID, 
				//onClose: function () { trace("MochiScore closed"); }
			//});
			
        }

		function onFailure(e:* = null):void
		{
			//trace("MochiServices failed to connect.");
		}
	}
}