package 
{
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class RudeBoy extends Dude 
	{
		public function RudeBoy() 
		{
			super();
			trace("hey dumbass!");
		}
		
		override protected function prepare(): void 
		{
			if (Math.random() > 0.5)
				actions.push(new Action(
					Action.MOVE, Game.DOOR_X - 100 - Math.random() * 50))
			else
				actions.push(new Action(
					Action.MOVE, Game.TRASH_CAN_X + Math.random() * 200));
			
			actions.push(new Action(
				Action.STAY, 1.5, Action.TRASH_LITTER));
			
			if (Math.random() > 0.5)
				actions.push(new Action(
					Action.MOVE, 640 + 200))
			else
				actions.push(new Action(
					Action.MOVE,-100));
		}
		
		override protected function onRelease():void 
		{
			super.onRelease();
			
			isDraggable = littered;
		}
		
		override protected function onDrag(): void 
		{
			y = Math.min(y, Game.FLOOR_Y - 20);
		}
		
		override protected function onDrop():void 
		{
			y = Game.FLOOR_Y;
			if (trash && Math.abs(x - trash.x) < 50)
				pickLitter();
		}
		
		protected function pickLitter(): void
		{
			littered = false;
			GameEvents.dispatch(GameEvents.STATS_PLUS_REFORMED);
			var sequence: Vector.<Action> = new Vector.<Action>();
			
			var sign: int = 1;
			if (x < trash.x)
				sign = -1;
			sequence.push(new Action(Action.MOVE, trash.x + 50 * sign));
			sequence.push(new Action(Action.STAY, 1.5, Action.TRASH_PICK));
			sign = 1;
			if (trash.x < Game.TRASH_CAN_X)
				sign = -1;
			sequence.push(new Action(Action.MOVE, Game.TRASH_CAN_X + 50 * sign));
			sequence.push(new Action(Action.STAY, 0.8, Action.TRASH_TO_CAN));
			sequence.push(action);
			
			actions = sequence.concat(actions);
		}
	}
}
