package
{
	import src.inventory.display.container.DefaultContainer;
	import src.inventory.display.container.Inventory;
	import src.inventory.display.container.Slot;
	import src.inventory.display.container.Level;	
	import src.inventory.display.item.ItemTypes;
	import src.inventory.display.item.Item01;
	
	// items
	import src.inventory.event.ItemEvent;	
	import src.inventory.display.item.DefaultItem;

	public class DisplayManager 
	{
		// reference to stage
		private var _canvas:Object;
		
		// display objects		
		private var _inventory:Inventory;
		private var _level:Level;		
		private var _slot:Slot;
		
		/**
		 * Constructor
		 * @param	$canvas A reference to stage in fla file
		 */
		public function DisplayManager($canvas:Object) 
		{
			_canvas = $canvas;
		}
		
		/**
		 * createInventory
		 * @param	$x
		 * @param	$y
		 * @param	$numberOfSlots
		 * @param	$numberOfColumns
		 */
		public function createInventory($x:int, $y:int, $numberOfSlots:int, $numberOfColumns:int):void
		{
			trace("createInventory");
			trace("\t number of slots: " + $numberOfSlots);
			trace("\t number of columns: " + $numberOfColumns);
			
			// create inventory container
			_inventory = new Inventory($numberOfSlots, $numberOfColumns);
			_inventory.x = $x;
			_inventory.y = $y;
			
			// add inventory to display list
			_canvas.addChild(_inventory);
		}
		
		/**
		 * createLevel
		 * @param	$x
		 * @param	$y
		 */
		public function createLevel($id:String, $x:int, $y:int):void
		{
			trace("createLevel");
			trace("\t level id: " + $id);
			
			// create level
			_level = new Level($id);
			_level.x = $x;
			_level.y = $y;
			
			// add level to display list
			_canvas.addChild(_level);
		}
		
		/**
		 * createItemInLevel
		 * @param	$itemId
		 * @param	$x
		 * @param	$y
		 */
		public function createItemInLevel($itemId:String, $x:int, $y:int):void
		{
			trace("createItemInLevel");
			trace("\t item id: " + $itemId);
			
			// create item
			var tempItem:DefaultItem = createItemGraphic($itemId, $x, $y);
			
			// set container
			tempItem.currentContainer = _level;
			_level.addNewItem(tempItem);
		}
		
		/**
		 * createItemInSlot
		 * @param	$itemId	Item ID string
		 * @param	$slotId	Slot ID string
		 */
		public function createItemInSlot($itemId:String, $slotId:String):void
		{
			trace("createItemInSlot");
			trace("\t item id: " + $itemId);
			trace("\t slot id: " + $slotId);
			
			// get slot
			var tempSlot:DefaultContainer = _inventory.getSlot($slotId);
			
			// create item
			var tempItem:DefaultItem = createItemGraphic($itemId, tempSlot.width / 2, tempSlot.height / 2);
			
			// set container
			tempItem.currentContainer = tempSlot;
			tempSlot.addItem(tempItem);
		}
		
		/**
		 * createItemGraphic
		 * @param	$id
		 * @param	$x
		 * @param	$y
		 * @return	DefaultItem
		 */
		private function createItemGraphic($itemId:String, $x:Number, $y:Number):DefaultItem
		{
			var tempItem:DefaultItem
			
			switch($itemId)
			{
				case "BitmapItem01":
				tempItem = new Item01("BitmapItem01", ItemTypes.WEAPON_LASER, $x, $y);
				break;
				
				case "BitmapItem02":
				tempItem = new Item02("BitmapItem02", ItemTypes.WEAPON_PROJECTILE, $x, $y);
				break;
				
				case "BitmapItem03":
				tempItem = new Item03("BitmapItem03", ItemTypes.WEAPON_LASER, $x, $y);
				break;
				
				case "BitmapItem04":
				tempItem = new Item04("BitmapItem04", ItemTypes.MATERIAL_CRYSTAL, $x, $y);
				break;
			}
			
			tempItem.addEventListener(ItemEvent.ITEM_PICKED_UP, onItemPickedUp);
			tempItem.addEventListener(ItemEvent.ITEM_DROPPED, onItemDropped);
			
			return tempItem;
		}
		
		/**
		 * Places item in slot container
		 * @param	$item	Uses DefaultItem
		 * @param	$level	Uses DefaultContainer
		 */
		private function placeItemInSlot($item:DefaultItem, $slot:DefaultContainer):void
		{
			trace("\t place item in slot: " + $slot);
			var newX:int = $slot.width / 2;
			var newY:int = $slot.height / 2;
			
			$item.x = newX;
			$item.y = newY;
			$item.lastX = newX;
			$item.lastY = newY;
			
			$item.currentContainer = $slot;
			$item.lastContainer = null;
			
			_inventory.addItemToSlot($item, $slot);
		}
		
		/**
		 * Places item in level container
		 * @param	$item	Uses DefaultItem
		 * @param	$level	Uses DefaultContainer
		 */
		private function placeItemInLevel($item:DefaultItem, $level:DefaultContainer):void
		{
			trace("\t place item in level: " + _level.id);
				
			$item.lastContainer = null;
			$item.currentContainer = $level;
			
			$item.x = $level.mouseX;
			$item.y = $level.mouseY;
			$item.lastX = $level.mouseY;
			$item.lastY = $level.mouseY;
			
			$level.addItem($item);
		}
		
		/**
		 * Pick up item
		 * @param	$item	Uses DefaultItem
		 */
		private function pickUpItem($item:DefaultItem):void
		{
			// save reference to item's current container
			$item.lastContainer = $item.currentContainer;
			
			// remove item from current container
			$item.currentContainer.removeItem($item);
			
			// add item to canvas
			_canvas.addChild($item);		
			
			// start dragging item
			$item.startDrag(true);
			
			// show selected frame
			$item.gotoAndStop(2);
			
			// add levels to the item
			$item.addLevels(1);
		}
		
		/**
		 * Drop item - checks where to drop item and how to do it
		 * @param	$item	Uses DefaultItem
		 */
		private function dropItem($item:DefaultItem):void
		{
			// remove item from canvas
			_canvas.removeChild($item);
			
			// stop dragging item
			$item.stopDrag();
			
			// show unselected frame
			$item.gotoAndStop(1);
			
			// check if item is being dropped in level
			if ($item.hitTestObject(_level))
			{
				placeItemInLevel($item, _level);
				
				// if item is being dropped in level container
				// abort all other checks
				return;
			}
			
			//check if item is being dropped in inventory
			else if ($item.hitTestObject(_inventory))
			{
				// temporary vars
				var placingInSlot:Boolean = false;
				var selectedSlot:Slot;
				var tempSlotsArray:Array = _inventory.getSlotsArray();
				var i:int;
				
				// run for loop on all inventory slots				
				for (i = 0; i < tempSlotsArray.length; i++)
				{
					// set temporary reference to slot
					var tempSlot:Slot = tempSlotsArray[i] as Slot;
					
					// if item hitting slot, and slot is empty
					if ($item.hitTestObject(tempSlot) && !tempSlot.hasItem())
					{
						// set flag for item to be placed in slot
						placingInSlot = true;
						selectedSlot = tempSlot;
					}
				}
				
				// if "place item in slot" is true
				if (placingInSlot)
				{
					placeItemInSlot($item, selectedSlot);
				}
				else
				{
					resetItemLocation($item);
				}
			}
			else
			{
				resetItemLocation($item);
			}
		}
		
		/**
		 * Resets item's container to it's previous container
		 * @param	$item	Uses DefaultItem
		 */
		private function resetItemLocation($item:DefaultItem):void
		{
			trace("resetItemLocation");
			trace("\t item id: " + $item.id);
			trace("\t container: " + $item.lastContainer);
			$item.x = $item.lastX;
			$item.y = $item.lastY;
			$item.currentContainer = $item.lastContainer;
			$item.lastContainer.addItem($item);
			$item.lastContainer = null;
		}
		
		/**
		 * Destroys inventory container and it's contents
		 */
		public function destroyInventory():void
		{
			_inventory.destroy();
			_canvas.removeChild(_inventory);
			_inventory = null;
		}
		
		/**
		 * Destroys level container and it's contents
		 */
		public function destroyLevel():void
		{
			_level.destroy();
			_canvas.removeChild(_level);
			_level = null;
		}
		
		//////////////////////////////////////
		// Event Handlers
		//////////////////////////////////////
		
		/**
		 * Item pickup handler
		 * @param	e ItemEvent 
		 */
		private function onItemPickedUp(e:ItemEvent):void 
		{
			trace("onItemPickedUp");			
			trace("\t item id: " + e.item.id);
			
			pickUpItem(e.item as DefaultItem);
		}
		
		/**
		 * Item drop handler
		 */
		private function onItemDropped(e:ItemEvent):void 
		{
			trace("onItemDropped");			
			trace("\t item id: " + e.item.id);
			
			dropItem(e.item as DefaultItem);
		}
		
	}
	
}