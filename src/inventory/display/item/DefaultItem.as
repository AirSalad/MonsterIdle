package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import src.inventory.display.container.DefaultContainer;
	import src.inventory.display.container.Slot;
	import src.inventory.display.container.Level;
	import src.inventory.event.ItemEvent;
	
	public class DefaultItem extends MovieClip
	{
		private var _id:String;
		private var _lastX:int;
		private var _lastY:int;
		private var _level:int = 0;
		private var _isStackable:Boolean = false;
		private var _type:String;
		private var _isDragging:Boolean = false;
		
		private var _currentContainer:DefaultContainer;
		private var _lastContainer:DefaultContainer;
		
		public function DefaultItem($id:String, $type:String, $x:int, $y:int)
		{
			stop();
			
			id = $id;			
			type = $type;
			
			x = $x;
			y = $y;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		public function init():void
		{
			buttonMode = true;
			mouseChildren = false;
			
			_lastX = x;
			_lastY = y;
			
			addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
		}
		
		/**
		 * Mouse Event Handlers
		 */		
		private function onMouseDownHandler(e:MouseEvent):void 
		{
			isDragging = true;
			
			dispatchEvent(new ItemEvent(ItemEvent.ITEM_PICKED_UP, this));
		}
		
		private function onMouseUpHandler(e:MouseEvent):void 
		{
			// check if item is being dragged
			if (isDragging)
			{
				dispatchEvent(new ItemEvent(ItemEvent.ITEM_DROPPED, this));
				
				isDragging = false;
			}
		}
		
		/**
		 * Custom functions for gameplay
		 */
		
		public function addLevels(additionalLevels:int):void
		{
			level += additionalLevels;
			trace(level);
		}
		/**
		 * Getters & Setters
		 */
		public function get id():String { return _id; }
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function get lastX():int { return _lastX; }
		
		public function set lastX(value:int):void 
		{
			_lastX = value;
		}
		
		public function get lastY():int { return _lastY; }
		
		public function set lastY(value:int):void 
		{
			_lastY = value;
		}
		
		
		public function get currentContainer():DefaultContainer { return _currentContainer; }
		
		public function set currentContainer(value:DefaultContainer):void 
		{
			_currentContainer = value;
		}
		
		public function get lastContainer():DefaultContainer { return _lastContainer; }
		
		public function set lastContainer(value:DefaultContainer):void 
		{
			_lastContainer = value;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get isDragging():Boolean 
		{
			return _isDragging;
		}
		
		public function set isDragging(value:Boolean):void 
		{
			_isDragging = value;
		}
		
		public function get level():int
		{
			return _level;
		}
		
		public function set level(value:int):void
		{
			_level = value;
		}
		
		/**
		 * Destroys item
		 */
		public function destroy():void
		{
			buttonMode = false;
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
		}
		
	}
	
}