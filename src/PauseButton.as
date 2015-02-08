package 
{
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class PauseButton extends Button 
	{
		private var paused: Boolean = false;
		
		public function PauseButton() 
		{
			super(Assets.getTexture("pause"));
			x = 640 - width * 2;
			y = height;
			addEventListener(Event.TRIGGERED, onTriggered);
		}
		
		private function onTriggered(e:Event):void 
		{
			Assets.playSound("pause_1");
			paused = !paused;
			if (paused)
				GameEvents.dispatch(GameEvents.PAUSE)
			else
				GameEvents.dispatch(GameEvents.RESUME);
		}
	}
}
