package lib {
	
	public class Global {
		
		public static var gameDataP1:Array;
		public static var gameDataP2:Array;
		
		public static var dataHistory:__AS3__.vec.Vector.<Array>;
		public static var statHistory:Array;

		public static var selectedPlace:uint;
		
		//oyunda kullanılan renkler.
		
		
		public static var gameDiffuculty:uint = 0;
		
		public static var colorLimit:uint = 0;
		public static var shapeLimit:uint = 0;
		public static var placeLimit:uint = 0;
		public static var turnLimit:uint = 0;
		
		public static var turnNum:uint = 0;
		public static var gameTime:uint = 0;
		public static var gameScore:int = 0;
		public static var gameDiffucultyName:String = "";
		
		public static var game:Boolean = false;
		public static var currentScore:int = 0;
		
		public function Global() {

		}
	}
	
}