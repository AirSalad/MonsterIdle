package
{
	import src.inventory.display.item.DefaultItem;
	import flash.text.TextField;
	
	public class Level extends DefaultContainer
	{
		private var _id:String;
		private var _items:Array;
		
		public function Level($id:String)
		{			
			_id = $id;
			_items = [];
		}
		
		public function addNewItem($item:DefaultItem):void
		{
			_items.push($item);
			
			addChild($item);
		}
		
		public override function addItem($item:DefaultItem):void
		{			
			_items.push($item);
			
			addChild($item);			
		}
		
		public override function removeItem($item:DefaultItem):void
		{
			var i:int;
			var tempItem:DefaultItem;
			
			for (i = 0; i < _items.length; i++)
			{
				tempItem = _items[i] as DefaultItem;
				if (tempItem.id == $item.id)
				{
					//found item, remove it
					removeChild($item);
					_items.splice(i, 1);
					return;
				}
			}
		}
		
		/**
		 * Getters & Setters
		 */
		public function getItemsArray():Array
		{
			return _items;
		}
		public function getTotalItems():int
		{
			return _items.length;
		}
		
		public function get id():String { return _id; }
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		/**
		 * Destory
		 */
		public function destroy():void
		{
			
		}
		
	}
	
}