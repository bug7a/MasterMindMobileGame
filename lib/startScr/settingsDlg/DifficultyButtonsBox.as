package lib.startScr.settingsDlg 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;	
	import flash.events.EventDispatcher;
	
	import lib.Global;
	import lib.Config;
	import com.flafolder.ui.ButtonA1;
	
	
	/**
	$(CBI)* ...
	$(CBI)* @author Buğra ÖZDEN
	$(CBI)*/
	public class DifficultyButtonsBox extends MovieClip
	{
		
		private static var _me:MovieClip;
		private static var _buttons:Array;
		private static var _selectedButtons:Array;
		private static var _pressedButtonID:uint;
		
		public static const staticDispatcher:EventDispatcher = new EventDispatcher();
		
		public function DifficultyButtonsBox() 
		{

		}
		
		//zorluk derecesi kadar button oluştur. ve yan yana ekle.
		public static function create() {
			
			if(_me == null) { 
			
				_me = new MovieClip();
				_buttons = new Array();
				_selectedButtons = new Array();
				
				_me.addEventListener(MouseEvent.CLICK, _mouseClick);
				
				_pressedButtonID = uint(Config.settings[0].difficulty);
				
				for (var i:uint = 0; i <=  Config.difficultyList.length - 1; i++) {
					
					var __button:ButtonA1 = new ButtonA1();
					var __selectedButton:SelectedButton = new SelectedButton();
					
					_buttons.push(__button);
					_selectedButtons.push(__selectedButton);
					
					__button.width = 35;
					__button.height = 35;
					
					_me.addChild(__selectedButton);
					_me.addChild(__button);
					
					__button.x = (__button.width * i);
					__selectedButton.x = __button.x;
					__button.y = 0;
					__selectedButton.y = 0;
					
					__button.label = String(i + 1);
					__selectedButton.number_txt.text = __button.label;
					
					__button.id = String(i);
					
					__selectedButton.visible = false;
					
					__button.useHandCursor = false;
					
					if (_pressedButtonID == i) {
						__button.visible = false;
						__selectedButton.visible = true;
						//__button.setStyle(ButtonA1.STYLE.SKIN, ButtonA1_defaultBlue );
						//__button.frame = ButtonA1.FRAME.DOWN; 
						//__button.visible = true;

					}
					
				}
			}
			
			return _me;
		}
		
		public static function refresh() {
			
			var __selectedButton:Object;
				
			var __oldButton:Object = _buttons[_pressedButtonID];
			__selectedButton = _selectedButtons[_pressedButtonID];
				
			__oldButton.visible = true;
				
			__selectedButton.visible = false;
			
			_pressedButtonID = uint(Config.settings[0].difficulty);
			
			var __newButton:Object = _buttons[_pressedButtonID];
			
			__newButton.visible = false;
			
			__selectedButton = _selectedButtons[_pressedButtonID];
			__selectedButton.visible = true;
			
		}
		
		private static function _mouseClick(e:MouseEvent) {
					
			if (e.target.parent.parent.id != undefined) {

				Config.settings[0].difficulty = uint(e.target.parent.parent.id);
				
				refresh();
				
				staticDispatcher.dispatchEvent(new Event("onChanged"));
			}
		}
	}
}