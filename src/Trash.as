package 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class Trash extends Sprite 
	{
		public function Trash() 
		{
			//addChild(new Quad(15, 15, 0xCE098E));
			addChild(Assets.getImage("trash"));
			alignPivot(HAlign.CENTER, VAlign.BOTTOM);
		}
	}
}
