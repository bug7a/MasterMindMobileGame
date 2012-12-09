package lib 
{
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import flash.sampler.NewObjectSample;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	public class SoundLib 
	{
		
		public static var music:Sound = new Music() as Sound;
		public static var over:Sound = new OverSnd() as Sound;
		public static var click:Sound = new ClickSnd() as Sound;
		public static var softClick:Sound = new SoftClickSnd() as Sound;
		public static var buttonClick:Sound = new ButtonClickSnd() as Sound;
		
		public static var won:Sound = new WonSnd();
		public static var gameover:Sound = new GameoverSnd();
		public static var notice:Sound = new NoticeSnd();
		public static var beep:Sound = new BeepSnd();
		
		private static var _channelMusic = new SoundChannel();
		
		private static var _musicTransform = new SoundTransform();
		public static var soundTransform = new SoundTransform();
		
		public function SoundLib() 
		{

		}
		
		public static function stopMusic() {
			TweenLite.to(_musicTransform, 1, { volume:0, ease:Circ.easeOut, onUpdate:_refreshMusic } );
			//_channelMusic.stop();
		}
		
		public static function playMusic() {
			//_musicTransform.volume = 0;
			_channelMusic.stop();
			_channelMusic = music.play();
			TweenLite.to(_musicTransform, 1, { volume:.4, ease:Circ.easeOut, onUpdate:_refreshMusic } );
		}
		
		private static function _clearMusic() {
			
		}
		
		private static function _refreshMusic() {
			_channelMusic.soundTransform = _musicTransform;
		}
		
		public static function stopEffect() {
			soundTransform.volume = 0;
		}
		
		public static function playEffect() {
			soundTransform.volume = 1;
		}
		
	}

}