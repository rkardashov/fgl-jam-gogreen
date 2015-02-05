package 
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class NumericView extends Sprite 
	{
		private var _value: int;
		private var digits: Vector.<Image>;
		
		public function NumericView() 
		{
			super();
			scaleX = scaleY = 0.33;
			digits = new Vector.<Image>();
			while (digits.length < 4)
			{
				digits.push(Assets.getImage("digit_0"));
				addChild(digits[digits.length - 1]);
			}
		}
		
		public function get value(): int
		{
			return _value;
		}
		public function set value(n: int): void 
		{
			_value = n;
			// TODO: show value
			for (var i:int = 0; i < String(n).length; i++)
			{
				digits[i].visible = true;
				digits[i].x = i * digits[i].width;
				digits[i].texture = Assets.getTexture("digit_" + String(n).charAt(i));
			}
			while (i < digits.length)
				digits[i++].visible = false;
		}
	}
}
