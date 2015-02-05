package 
{
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class Dude extends Draggable
	{
		static public const SPEED: Number = 100;
		static public const MAX_CLICKS: int = 7;
		
		static public const STATE_MOVING:String = "moving";
		
		private var speed: Number;
		private var dx: Number = 0;
		private var dt: Number = 0;
		private var clicks: int = 0;
		protected var actions: Vector.<Action> = new Vector.<Action>;
		protected var action: Action;
		protected var littered: Boolean = false;
		private var anim: MovieClip;
		private var anims: Object;
		
		public var trash: Trash = new Trash();
		
		public function Dude() 
		{
			super();
			prepare();
			
			anims = { };
			for each (var s: String in [
				"stay_simple", "stay_hit", "hit", "drag", "die", "run",
				"pick_trash", "trash_simple", "trash_hit",
				"walk_simple", "walk_hit", "walk_with_trash"
				]) 
			{
				anims[s] = Assets.getAnim("dude_" + s + "_");
				Starling.juggler.add(anims[s]);
			}
			
			for each (s in ["hit", "die", "pick_trash",
				"trash_simple", "trash_hit"]) 
			{
				(anims[s] as MovieClip).loop = false;
			}
			setAnim("stay_simple");
			
			alignPivot(HAlign.CENTER, VAlign.BOTTOM);
			x = 300;
			y = Game.FLOOR_Y;
			
			speed = SPEED;
			if (Math.random() > 0.5)
				speed = - SPEED;
			isDraggable = false;
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			GameEvents.subscribe(GameEvents.PAUSE, onPause);
			GameEvents.subscribe(GameEvents.RESUME, onResume);
			GameEvents.subscribe(GameEvents.GAME_OVER, onGameOver);
			
			nextAction();
		}
		
		protected function prepare():void 
		{
		}
		
		private function onPause(e: Event):void 
		{
			removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			if (anim)
				anim.pause();
		}
		private function onResume(e: Event):void 
		{
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			if (anim)
				anim.play();
		}
		
		private function onGameOver():void 
		{
			kill();
		}
		
		override protected function onRelease(): void
		{
			if (++clicks > MAX_CLICKS)
			{
				// TODO: animate explosion
				kill();
				GameEvents.dispatch(GameEvents.STATS_PLUS_ELIMINATED);
				return;
			}
			actions.unshift(action);
			//actions.unshift(new Action(Action.STAY, 2.0));
			//nextAction();
			action = new Action(Action.STAY, 0.5);
			setAnim("hit");
		}
		
		private function onEnterFrame(e: EnterFrameEvent): void 
		{
			if (isDragging || !action)
				return;
				
			if (action.type == Action.MOVE)
			{
				dx = action.target - x;
				if (Math.abs(dx) <= 1)
				{
					//action = actions.shift();
					nextAction();
					return;
				}
				//state = STATE_MOVING;
				speed = SPEED * (dx) / Math.abs(dx);
				x += speed * e.passedTime;
				scaleX = (dx) / Math.abs(dx);
				if (x > 800 || x < -width)
					kill();
			}
			if (action.type == Action.STAY)
			{
				dt += e.passedTime;
				if (dt >= action.target)
				{
					dt = 0;
					//action = actions.shift();
					
					if (action.trash == Action.TRASH_PICK)
					{
						trash.removeFromParent();
						GameEvents.dispatch(GameEvents.TRASH_PICK);
					}
					
					if (action.trash == Action.TRASH_LITTER)
					{
						trash.x = x - 50 * scaleX;
						trash.y = y;
						GameEvents.dispatch(GameEvents.LITTER, trash);
						littered = true;
					}
					if (action.trash == Action.TRASH_TO_CAN)
						GameEvents.dispatch(GameEvents.TRASH_TO_CAN);
					action.trash = "";
					
					
					nextAction();
					return;
				}
			}
		}
		
		private function setAnim(animID: String): void 
		{
			if (anim)
			{
				anim.stop();
				anim.removeFromParent();
			}
			anim = anims[animID];
			addChild(anim);
			anim.stop();
			//anim.currentFrame = 0;
			anim.play();
			alignPivot(HAlign.CENTER, VAlign.BOTTOM);
		}
		
		private function kill(): void 
		{
			removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			removeFromParent();
			trash = null;
			//GameEvents.dispatch(GameEvents.DUDE_DIE, this);
		}
		
		private function nextAction(): void 
		{
			/*if (action)
			{
				if (action.trash == Action.TRASH_PICK)
				{
					trash.removeFromParent();
					GameEvents.dispatch(GameEvents.TRASH_PICK);
				}
				
				if (action.trash == Action.TRASH_LITTER)
				{
					trash.x = x - 50 * scaleX;
					trash.y = y;
					GameEvents.dispatch(GameEvents.LITTER, trash);
					littered = true;
				}
				if (action.trash == Action.TRASH_TO_CAN)
					GameEvents.dispatch(GameEvents.TRASH_TO_CAN);
				action.trash = "";
				
				if (action.type == Action.MOVE)
				{
					dx = action.target - x;
					if (Math.abs(dx) < 5)
					{
						//action = actions.shift();
						nextAction();
						return;
					}
					//state = STATE_MOVING;
					speed = SPEED * (dx) / Math.abs(dx);
					x += speed * e.passedTime;
					scaleX = (dx) / Math.abs(dx);
					if (x > 800 || x < -width)
						kill();
				}
				if (action.type == Action.STAY)
				{
					dt += e.passedTime;
					if (dt >= action.target)
					{
						dt = 0;
						//action = actions.shift();
						nextAction();
						return;
					}
				}
			}*/
			
			
			
			
			action = actions.shift();
			dt = 0;
			
			if (!action)
				return;
			
			//if (action.type == Action.STAY)
			switch (action.type)
			{
				case Action.STAY:
					switch (action.trash)
					{
						case Action.TRASH_PICK:
							setAnim("pick_trash");
							break;
						case Action.TRASH_TO_CAN:
						case Action.TRASH_LITTER:
							if (clicks > 0)
								setAnim("trash_hit")
							else
								setAnim("trash_simple");
							break;
						case "":
							if (clicks > 0)
								setAnim("stay_hit")
							else
								setAnim("stay_simple");
							break;
					}
					break;
					
				case Action.MOVE:
					if (clicks > 0)
						setAnim("walk_hit")
					else
						setAnim("walk_simple");
					break;
			}
			/*
			 * "drag" - set on drag start
			 * "die", - set on touch(N)
			 (* "run", - later)
			 * "stay_simple"
			 * "stay_hit",
				"pick_trash",
				"trash_to_can_simple",
				"trash_to_can_hit",
				"walk_simple",
				"walk_hit",
				
				"walk_with_trash": TODO
				]) 
			 */
		}
	}
}
