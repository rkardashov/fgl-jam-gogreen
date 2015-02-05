package 
{
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class TimeCounter extends Sprite 
	{
		//private var text: TextField;
		private var text: NumericView;
		private var time: Number = 0;
		
		public function TimeCounter() 
		{
			super();
			/*addChild(text = new TextField(125, 30, "", "Arcade_10", 20, 0xED715F));
			text.autoScale = false;
			text.vAlign = VAlign.BOTTOM;
			text.hAlign = HAlign.LEFT;
			text.text = "";*/
			addChild(text = new NumericView());
			
			alignPivot(HAlign.LEFT, VAlign.CENTER);
			x = 100;
			y = 50;
			
			//addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			GameEvents.subscribe(GameEvents.GAME_OVER, onGameOver);
			GameEvents.subscribe(GameEvents.PAUSE, onPause);
			GameEvents.subscribe(GameEvents.RESUME, onResume);
		}
		
		private function onPause(e: Event):void 
		{
			removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		private function onResume(e: Event):void 
		{
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		private function onGameOver():void 
		{
			GameEvents.dispatch(GameEvents.STATS_TOTAL_TIME, time);
			time = 0;
			removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void 
		{
			time += e.passedTime;
			//text.text = time.toFixed();
			text.value = time;
		}
	}
}
