package 
{
	import flash.events.TimerEvent;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class GameOverView extends Button 
	{
		private var time:NumericView;// TextField;
		//private var btnRestart:Button;
		//private var statsGoodBoys: int;
		//private var statsReformed: int;
		//private var statsEliminated: int;
		private var textGoodBoys: NumericView;
		private var textReformed: NumericView;
		private var textEliminated: NumericView;
		private var timer: Timer = new Timer(600);
		
		public function GameOverView() 
		{
			super(Assets.getTexture("bg_game_over"));
			//addChild(Assets.getImage("bg_game_over"));
			x = 320 + 640;
			y = 240;
			alignPivot();
			addEventListener(starling.events.Event.TRIGGERED, onRestart);
			
			/*addChild(time = new TextField(125, 30, "", "Arcade_10", 20, 0xFFFFFF));
			time.autoScale = false;
			time.vAlign = VAlign.TOP;
			time.hAlign = HAlign.LEFT;
			time.text = "";*/
			addChild(time = new NumericView());
			time.scaleX = time.scaleY = 0.25;
			time.x = 350;
			time.y = 30; // 351, 33
			
			
			addChild(textGoodBoys = new NumericView());
			textGoodBoys.x = 320;
			textGoodBoys.y = 50; // 340, 50 
			textGoodBoys.scaleX = textGoodBoys.scaleY = 0.25;
			
			addChild(textReformed = new NumericView());
			textReformed.x = 330;
			textReformed.y = 70; // 70
			textReformed.scaleX = textReformed.scaleY = 0.25;
			
			addChild(textEliminated = new NumericView());
			textEliminated.x = 340;
			textEliminated.y = 90; // 90
			textEliminated.scaleX = textEliminated.scaleY = 0.25;
			
			/*addChild(btnRestart = new Button(Assets.getTexture("restart")));
			btnRestart.x = 280;
			btnRestart.y = 80;
			btnRestart.addEventListener(Event.TRIGGERED, onRestartBtn);*/

			visible = false;
			GameEvents.subscribe(GameEvents.GAME_START, onGameStart);
			GameEvents.subscribe(GameEvents.GAME_OVER, onGameOver);
			
			GameEvents.subscribe(GameEvents.STATS_TOTAL_TIME, onTotalTime);
			GameEvents.subscribe(GameEvents.STATS_PLUS_GOOD_BOY, onPlusGoodBoy);
			GameEvents.subscribe(GameEvents.STATS_PLUS_REFORMED, onPlusReformed);
			//GameEvents.subscribe(GameEvents.STATS_PLUS_ELIMINATED, onPlusEliminated);
			
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		private function onGameStart(): void 
		{
			//statsGoodBoys = 0;
			//statsReformed = 0;
			//statsEliminated = 0;
			textGoodBoys.value = 0;
			textReformed.value = 0;
			textEliminated.value = 0;
		}
		
		private function onPlusGoodBoy(): void 
		{
			textGoodBoys.value ++;
		}
		
		private function onPlusReformed():void 
		{
			textReformed.value ++;
		}
		
		private function onPlusEliminated():void 
		{
			textEliminated.value ++;
		}
		
		private function onRestart(e:starling.events.Event):void 
		{
			timer.stop();
			Assets.playSound("car_depart");
			Starling.juggler.tween(this, 3,
			{
				x: 320 - 640,
				transition: Transitions.EASE_IN_OUT,
				onComplete: function(): void
				{
					visible = false;
					x = 320 + 640;
					GameEvents.dispatch(GameEvents.GAME_START);
				}
			});
		}
		
		private function onTotalTime(e: starling.events.Event, t: int): void 
		{
			//time.text = "time: " + String(t) + " sec";
			time.value = t;
		}
		
		private function onGameOver():void 
		{
			visible = true;
			Assets.playSound("car_start");
			setTimeout(Assets.playSound, 1000, "car_arrive");
			setTimeout(timer.start, 2300);
			
			Starling.juggler.tween(this, 3,
			{
				x: 320,
				transition: Transitions.EASE_IN_OUT//,
				//onComplete: timer.start
				/*function(): void
				{
					Assets.playSound("car_wait", true);
					timer.start();
				}*/
			});
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			Assets.playSound("car_wait");// , true);
		}
	}
}
