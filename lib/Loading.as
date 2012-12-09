package lib {
	
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	
	import flash.system.SecurityDomain;
	import flash.system.Security;
	
	
	public class Loading extends MovieClip {
		
		public var loader:Loader=new Loader();
		public var main:MovieClip;
		
		public function Loading() {
		  stop();
		  stage.scaleMode = StageScaleMode.NO_SCALE;
		  
		  Security.allowDomain("*");
		  Security.allowInsecureDomain("*");

		  addChild(loader);
		  loader.load(new URLRequest("http://www.flafolder.com/games/new.mastermind/play/NewMasterMind.swf"));
		  loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onMainLoadProgress);
		  
		}

		protected function destroy():void
		{
		  loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onMainLoadProgress);
		}
	 
		protected function onMainLoadProgress(e:ProgressEvent):void
		{
		  var percent:Number = Math.round((e.bytesLoaded / e.bytesTotal )*100 );
		  loading.bar.part.width = int(percent);
		  if(percent < 1 || percent > 99) {
			  loading.alpha = 0;
		  }else {
			  loading.alpha = 1;
		  }
		  if (e.bytesLoaded == e.bytesTotal ){ destroy(); };
		}
	}
	
}
