package lib.startScr 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import lib.Global;
	import lib.Config;
	import lib.SoundLib;
	
	import lib.startScr.settingsDlg.DifficultyButtonsBox;

	public class SettingsDlg extends MovieClip
	{
		
		private var _difficultyButtonsBox:MovieClip;
		
		public function SettingsDlg() 
		{
			this.visible = false;
			
			_difficultyButtonsBox = DifficultyButtonsBox.create();
			addChild(_difficultyButtonsBox);

			_difficultyButtonsBox.x = 164 - int(_difficultyButtonsBox.width / 2);
			
			_difficultyButtonsBox.y = 95;

			DifficultyButtonsBox.staticDispatcher.addEventListener("onChanged", _refreshDifficultyBox);
			
			_refreshDifficultyBox();
			
			closeBtn.addEventListener(MouseEvent.CLICK, _closeMe);
			
			musicBtn.toggleButton = true;
			soundBtn.toggleButton = true;
			
			musicBtn.toggleValue = Config.settings[0].music;
			soundBtn.toggleValue = Config.settings[0].sound;
			
			musicBtn.addEventListener(MouseEvent.CLICK, _musicBtnClick);
			soundBtn.addEventListener(MouseEvent.CLICK, _soundBtnClick);
			
		}
		
		public function refresh() {
			DifficultyButtonsBox.refresh();
		}
		
		private function _refreshDifficultyBox(e:Event = null) {
			
			trace("current settings: " + Config.settings[0].difficulty);
			difficultyName_txt.text = Config.difficultyList[Config.settings[0].difficulty].name;
			placeNum_txt.text = Config.difficultyList[Config.settings[0].difficulty].placeLimit;
			colorNum_txt.text = Config.difficultyList[Config.settings[0].difficulty].colorLimit;
			shapeNum_txt.text = Config.difficultyList[Config.settings[0].difficulty].shapeLimit;
			
		}
		
		private function _musicBtnClick(e:MouseEvent = null) {
			Config.settings[0].music = musicBtn.toggleValue;
			if (Config.settings[0].music) SoundLib.playMusic() else SoundLib.stopMusic();
		}
		
		private function _soundBtnClick(e:MouseEvent = null) {
			Config.settings[0].sound = soundBtn.toggleValue;
			if (Config.settings[0].sound) SoundLib.playEffect() else SoundLib.stopEffect();
		}
		
		private function _closeMe(e:MouseEvent):void {
			dispatchEvent(new Event("Close"));
		}
		
	}

}