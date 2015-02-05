package 
{
	import flash.geom.Point;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class Draggable extends Sprite 
	{
		private var touchLocation: Point;
		private var touchOffset: Point;
		
		protected var isDraggable: Boolean = true;
		protected var isPicked:Boolean = false;
		protected var isDragging: Boolean = false;
		
		public function Draggable() 
		{
			super();
			addEventListener(TouchEvent.TOUCH, _onTouch);
		}
		
		private function _onTouch(e:TouchEvent):void 
		{
			if (!parent)
				return;
			var touch: Touch = e.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				onTouch();
				touchOffset = touch.getLocation(parent);
				touchOffset.offset( -x, -y);
				if (isDraggable)
					isPicked = true;
			}
			
			touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch && !isDragging)
				onRelease();
			if (touch && isPicked)
			{
				isPicked = false;
				onDrop();
			}
			
			touch = e.getTouch(this, TouchPhase.MOVED);
			isDragging = (isDraggable && touch != null);
			if (isDragging)
			{
				touchLocation = touch.getLocation(parent);
				x = int(touchLocation.x - touchOffset.x);
				y = int(touchLocation.y - touchOffset.y);
				onDrag();
			}
		}
		
		protected function onTouch(): void 
		{
		}
		
		protected function onDrag(): void 
		{
			
		}
		
		protected function onDrop(): void 
		{
		}
		
		protected function onRelease(): void
		{
			
		}
	}
}
