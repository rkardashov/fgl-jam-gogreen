package 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class TrashCan extends Sprite 
	{
		private var layerTrash: Sprite;
		
		public function TrashCan(xPos: Number) 
		{
			//addChild(new Quad(45, 75, 0x146312));
			addChild(Assets.getImage("trashcan"));
			addChild(layerTrash = new Sprite());
			alignPivot(HAlign.CENTER, VAlign.BOTTOM);
			x = xPos;
			y = Game.FLOOR_Y - 10;
			
			GameEvents.subscribe(GameEvents.TRASH_TO_CAN, onTrashToCan);
		}
		
		private function onTrashToCan(e: Event/*, t: Trash*/): void 
		{
			var t: Trash = new Trash();
			t.x = 15 + 15 * (layerTrash.numChildren % 2) + Math.random() * 4 - 2;
			t.y = height - 10 - 8 * (layerTrash.numChildren >> 1)  + Math.random() * 6 - 3;
			layerTrash.addChild(t);
		}
	}
}
