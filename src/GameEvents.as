package 
{
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class GameEvents 
	{
		static public const GAME_START:String = "game_start";
		static public const GAME_OVER: String = "game_over";
		
		static public const PAUSE: String = "game_pause";
		static public const RESUME: String = "game_resume";
		
		static public const LITTER: String = "litter";
		static public const TRASH_TO_CAN: String = "trash";
		static public const TRASH_PICK: String = "trash_pick";
		
		static public const STATS_TOTAL_TIME: String = "totalTime";
		static public const STATS_PLUS_GOOD_BOY: String = "statsPlusGoodBoy";
		static public const STATS_PLUS_REFORMED: String = "statsPlusReformed";
		static public const STATS_PLUS_ELIMINATED: String = "statsPlusEliminated";
		
		static public function subscribe(eventType: String, handler: Function): void 
		{
			Starling.current.stage.addEventListener(eventType, handler);
		}
		
		static public function unsubscribe(eventType: String, handler: Function): void 
		{
			Starling.current.stage.removeEventListener(eventType, handler);
		}
		
		static public function dispatch(eventType: String, data: Object = null): void
		{
			Starling.current.stage.dispatchEventWith(eventType, false, data);
		}
		static public function dispatchEvent(event: Event): void
		{
			Starling.current.stage.dispatchEvent(event);
		}
	}
}
