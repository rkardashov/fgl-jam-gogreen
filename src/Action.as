package 
{
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class Action 
	{
		static public const MOVE: String = "move";
		static public const STAY: String = "stay";
		
		static public const TRASH_TO_CAN: String = "trashToCan";
		static public const TRASH_LITTER: String = "trashLitter";
		static public const TRASH_PICK: String = "trashPick";
		
		public var type:String;
		public var start: Number;
		public var target: Number;
		public var trash: String;
		
		public function Action(type: String, target: Number, trash: String = "") 
		{
			this.type = type;
			this.target = target;
			this.trash = trash;
		}
	}
}
