package 
{
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class Game extends Sprite 
	{
		/*private var scoreCounter: ScoreCounter;
		
		private var score: int;
		*/
		static public const TRASH_CAN_X:Number = 400;
		static public const FLOOR_Y: Number = 320;
		static public const DOOR_X: Number = 240;
		
		static private const MAX_TRASH: int = 0;// 3;
		static private const DUDE_INTERVAL:Number = 3;
		
		private var gameOver: Boolean;
		private var layerObjects:Sprite;
		private var door:Image;
		private var nextDudeTime:Number;
		private var dt:Number;
		private var layerUI:Sprite;
		private var pauseScreen:Image;
		private var layerTrash:Sprite;
		private var gameOverView:GameOverView;
		private var music: SoundController;
		
		public function Game(): void 
		{
			Assets.init(onAssetsLoaded);
		}
		
		private function onAssetsLoaded():void 
		{
			//Assets.playSound("music_bg");// Assets.SOUND_SUPERMARKET);
			music = new SoundController("music_bg");
			//Assets.getSound("music_bg").play();// Assets.SOUND_SUPERMARKET);
			
			addChild(Assets.getImage("bg"));
			clipRect = new Rectangle(0, 0, 640, 480);
			
			addChild(door = Assets.getImage("door_1"));
			door.alignPivot(HAlign.CENTER, VAlign.BOTTOM);
			door.x = DOOR_X;
			door.y = FLOOR_Y;
			
			addChild(layerObjects = new Sprite());
			layerObjects.addChild(new TrashCan(TRASH_CAN_X));
			
			addChild(layerTrash = new Sprite());
			
			addChild(pauseScreen = Assets.getImage("pause_screen"));
			pauseScreen.visible = false;
			
			addChild(layerUI = new Sprite());
			layerUI.addChild(new PauseButton());
			layerUI.addChild(new TimeCounter());
			
			addChild(gameOverView = new GameOverView());
			
			addChild(/*titleScreen = */new TitleScreen());
			//titleScreen.visible = true;
			
			var vignette: Image = Assets.getImage("vignette");
			vignette.alpha = 0.8;
			vignette.touchable = false;
			addChild(vignette);
			
			GameEvents.subscribe(GameEvents.GAME_START, onGameStart);
			GameEvents.subscribe(GameEvents.GAME_OVER, onGameOver);
			
			GameEvents.subscribe(GameEvents.PAUSE, onPause);
			GameEvents.subscribe(GameEvents.RESUME, onResume);
			
			GameEvents.subscribe(GameEvents.LITTER, onLitter);
			GameEvents.subscribe(GameEvents.TRASH_PICK, onTrashPick);
			
			//GameEvents.dispatch(GameEvents.GAME_START);
		}
		
		private function onGameStart():void 
		{
			reset();
			GameEvents.dispatch(GameEvents.RESUME);
		}
		
		private function onPause(e: Event):void 
		{
			pauseScreen.visible = true;
			removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		private function onResume(e: Event):void 
		{
			pauseScreen.visible = false;
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void 
		{
			if (gameOver)
				return;
			dt += e.passedTime;
			if (dt >= nextDudeTime)
			{
				dt = 0;
				//nextDudeTime = DUDE_INTERVAL_MIN + Math.random() * 2;
				nextDudeTime = DUDE_INTERVAL * (0.8 + Math.random() * 0.4);
				var dudeClass: Class = [GoodBoy, Fool, RudeBoy][int(Math.random() * 3)];
				layerObjects.addChild(new dudeClass());
			}
		}
		
		private function reset(): void 
		{
			gameOver = false;
			layerTrash.removeChildren();
			layerUI.y = 0;
			dt = 0;
			nextDudeTime = 2;
		}
		
		private function onLitter(e: Event, trash: Trash): void 
		{
			//var t: Trash = new Trash();
			//t.x = litterX;
			//t.y = 450;
			trash.removeFromParent();
			layerTrash.addChild(trash);
			if (layerTrash.numChildren > MAX_TRASH)
				GameEvents.dispatch(GameEvents.GAME_OVER);
		}
		
		private function onTrashPick():void 
		{
			if (layerTrash.numChildren > MAX_TRASH)
				GameEvents.dispatch(GameEvents.GAME_OVER);
		}
		
		private function onGameOver():void 
		{
			gameOver = true;
			Starling.juggler.tween(layerUI, 1,
			{
				y: -100,
				transition: Transitions.EASE_OUT
			});
			/*music.soundTransform.volume = 0.2;
			music.soundTransform = music.soundTransform;*/
			Starling.juggler.tween(music, 1,
			{
				volume: 0,
				transition: Transitions.LINEAR
			});
			removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
	}
}