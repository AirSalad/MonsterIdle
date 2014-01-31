package
{
	import src.inventory.display.item.DefaultItem;
	import src.inventory.display.container.Slot;	
	import flash.text.TextField;
	
	public class Inventory extends DefaultContainer
	{
		// vars
		private var _slots:Array;
		
		// settings
		private var _paddingVertically:int = 32;
		private var _paddingHorizontally:int = 5;
		
		// data
		private var _numberOfSlots:int;
		private var _numberOfColumns:int;
		
		/**
		 * Constructor
		 * 
		 * @param	$numberOfSlots
		 * @param	$numberOfColumns
		 */
		public function Inventory($numberOfSlots:int, $numberOfColumns:int)
		{
			_numberOfSlots = $numberOfSlots;
			_numberOfColumns = $numberOfColumns;			
			
			_slots = [];
			
			var tempSlot:Slot;					
			var currentColumn:uint = 0;			
			var currentRow:uint = 0;			
			var currentSlots:uint = 0;
			
			var i:int;
			for (i = 0; i < _numberOfSlots; i++)
			{
				var newId:String = "i" + int(i + 1);
				tempSlot = new Slot(newId);
				tempSlot.x = _paddingHorizontally + tempSlot.width * currentColumn;
				tempSlot.y = _paddingVertically + tempSlot.height * currentRow;
				
				addSlot(tempSlot);
				
				currentColumn++;
				if (currentColumn == _numberOfColumns)
				{
					currentRow++;
					currentColumn = 0;
				}
			}
		}
		
		/**
		 * addItemToSlot	Adds items to slot
		 * 
		 * @param	$item
		 * @param	$slot
		 */
		public function addItemToSlot($item:DefaultItem, $slot:DefaultContainer):void
		{
			// position item in center of slot
			$item.x = $slot.width / 2;
			$item.y = $slot.height / 2;
			
			// add item to slot
			$slot.addItem($item);
		}
		
		/**
		 * addSlot	Adds slot to inventory
		 * 
		 * @param	$slot
		 */
		public function addSlot($slot:Slot):void
		{
			_slots.push($slot);
			addChild($slot);
		}
		
		/**
		 * getSlotsArray
		 * 
		 * @return	Slots array
		 */
		public function getSlotsArray():Array
		{
			return _slots;
		}
		
		/**
		 * 
		 * @return	Total number of slots in this inventory
		 */
		public function getTotalSlots():int
		{
			return _slots.length;
		}
		
		/**
		 * Get slot based on slotId
		 * @param	$slotId	Slot ID string
		 * @return	Slot
		 */
		public function getSlot($slotId:String):Slot
		{
			var i:int;
			var tempSlot:Slot;
			
			for (i = 0; i < _slots.length; i++)
			{
				tempSlot = _slots[i] as Slot;
				
				if (tempSlot.id == $slotId)
				{
					return tempSlot;
				}
				
			}
			
			trace("! Slot ID '" + $slotId + "' not found!");
			return null;
		}
		
		/**
		 * Finds empty slot in inventory
		 * @return
		 */
		public function findEmptySlot():Slot
		{
			var i:int;
			var tempSlot:Slot;
			
			for (i = 0; i < _slots.length; i++)
			{
				tempSlot = _slots[i] as Slot;
				
				if (tempSlot.hasItem == false)
				{
					return tempSlot;
				}
				
			}
			
			trace("Inventory Full! No empty slots.");
			return null;
		}
		
		/**
		 * Finds and removes item from inventory
		 * 
		 * @param	$item	Item you want removed
		 */
		public override function removeItem($item:DefaultItem):void
		{
			var i:int;
			var tempSlot:Slot;
			
			for (i = 0; i < _slots.length; i++)
			{
				tempSlot = _slots[i] as Slot;
				
				if (tempSlot.getItem().id == $item.id)
				{
					//found item, remove it
					removeChild($item);
					
					tempSlot.removeItem($item);
					
					//_slots[i].
					_slots.splice(i, 1);
					return;
				}
			}
		}
		
		/**
		 * Destroys all items and slots in inventory
		 */
		public function destroy():void
		{
			var i:int;
			var tempSlot:Slot;
			
			for (i = 0; i < _slots.length; i++)
			{
				tempSlot = _slots[i] as Slot;
				tempSlot.destroy();
				_slots.splice(i, 1);
				removeChild(tempSlot);
				tempSlot = null;
			}
		}
		
	}
	
}