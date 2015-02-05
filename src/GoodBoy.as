package 
{
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class GoodBoy extends Dude 
	{
		public function GoodBoy() 
		{
			super();
			//trace("good boy here!");
			GameEvents.dispatch(GameEvents.STATS_PLUS_GOOD_BOY);
		}
		
		override protected function prepare(): void 
		{
			actions.push(new Action(
				Action.MOVE, Game.TRASH_CAN_X + 50));
			
			actions.push(new Action(
				Action.STAY, Math.random() + 0.5, Action.TRASH_TO_CAN));
				
			if (Math.random() > 0.5)
				actions.push(new Action(
					Action.MOVE, 640 + 200))
			else
				actions.push(new Action(
					Action.MOVE,-100));
		}
	}
}
