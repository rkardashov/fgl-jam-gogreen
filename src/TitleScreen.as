package 
{
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class TitleScreen extends Sprite 
	{
		private var howToPlay: Button;
		
		public function TitleScreen() 
		{
			super();
			addChild(Assets.getImage("title_bg"));
			var btn: Button;
			addChild(btn = new Button(Assets.getTexture("btn_start")));
			btn.x = 320 - 140;
			btn.y = 300;
			btn.alignPivot();
			btn.addEventListener(Event.TRIGGERED, onStartTrigger);
			addChild(btn = new Button(Assets.getTexture("btn_how_to_play")));
			btn.x = 320 + 140;
			btn.y = 300;
			btn.alignPivot();
			btn.addEventListener(Event.TRIGGERED, onShowHowToPlay);
			
			addChild(howToPlay = new Button(Assets.getTexture("bg_how_to_play")));
			howToPlay.x = 320;
			howToPlay.y = 240;
			howToPlay.alignPivot();
			howToPlay.addEventListener(Event.TRIGGERED, onCloseHowToPlay);
			howToPlay.visible = false;
		}
		
		private function onShowHowToPlay(e:Event):void 
		{
			howToPlay.visible = true;
		}
		
		private function onCloseHowToPlay(e:Event):void 
		{
			howToPlay.visible = false;
		}
		
		private function onStartTrigger(e:Event):void 
		{
			Starling.juggler.tween(this, 2,
			{
				alpha: 0,
				transition: Transitions.EASE_IN_OUT,
				onComplete: function(): void
				{
					visible = false;
					//x = 320 + 640;
					GameEvents.dispatch(GameEvents.GAME_START);
				}
			});
		}
	}
}
