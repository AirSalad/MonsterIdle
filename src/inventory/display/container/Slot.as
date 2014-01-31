package
{
	import src.inventory.display.item.DefaultItem;
	import flash.text.TextField;
	
	public class Slot extends DefaultContainer
	{
		// vars
		private var _id:String;		
		private var _item:DefaultItem;
		
		/**
		 * Constructor
		 * 
		 * @param	$id	Slot id
		 */
		public function Slot($id:String) 
		{
			id = $id;
			
			setLabel($id);
			
			stop();
		}
		
		/**
		 * Slot Methods
		 */
		public function getItem():DefaultItem { return _item; }
		
		public override function addItem($item:DefaultItem):void 
		{
			_item = $item;
			addChild(_item);
			
			//
			this.gotoAndStop(2);
		}
		
		public override function removeItem($item:DefaultItem):void
		{
			removeChild(_item);
			_item = null;
			
			this.gotoAndStop(1);
		}
		
		public function hasItem():Boolean
		{
			if (_item == null)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		
		/**
		 * Getters & Setters
		 */
		public function get id():String { return _id; }
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function setLabel($label:String):void
		{
			this.label.text = $label;
		}
		
		
		/**
		 * Destroy
		 */
		public function destroy():void
		{
			removeItem(_item)
		}
		
		
	}
	
}