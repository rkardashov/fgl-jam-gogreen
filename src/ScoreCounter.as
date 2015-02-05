package  
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class ScoreCounter extends Sprite 
	{
		
		public function ScoreCounter() 
		{
			super();
		}
		
		public function setScore(score: int, max: int): void 
		{
			removeChildren();
			var q: Quad;
			var color: uint = 0x33FF33;
			for (var i:int = 0; i <= Math.max(score, max); i++) 
			{
				if (i < score)
					color = 0xFFFF00;
				if (i >= max)
					color = 0x33FF33;
				if (i < score || i == max)
				{
					/*addChild(q = new Quad(40, 40, 0x444444));
					q.x = 0;
					q.y = -i * 8 + 3;
					q.skewX = 0.3;*/
					addChild(q = new Quad(20, 20, color));
					/*q.x = 0;
					q.y = -i * 4;
					q.skewX = Math.PI / 8;*/
					q.x = i * 10;
					q.y = 0;
					q.skewY = -Math.PI / 6;
				}
			}
		}
	}
}
