package
{
	import src.inventory.DisplayManager;
	
	public class InventorySystem 
	{
		private var _displayManager:DisplayManager;
		
		private var _canvas:Object;
		
		/**
		 * Constructor
		 * 
		 * @param	$canvas A reference to stage in fla file
		 */
		public function InventorySystem($canvas:Object) 
		{
			_canvas = $canvas;
			
			_displayManager = new DisplayManager(_canvas);
			
			// createInventory(x, y, slots, columns);
			_displayManager.createInventory(10, 10, 18, 3);
			
			// inventory ready.
			
			// createLevel(level id, x, y);
			_displayManager.createLevel("myWorld", 190, 10);
			
			// level ready.
			
			//createItemInLevel(item id, x, y);
			_displayManager.createItemInLevel("BitmapItem01", 75, 100);
			_displayManager.createItemInLevel("BitmapItem02", 180, 125);
			_displayManager.createItemInLevel("BitmapItem03", 250, 90);
			
			_displayManager.createItemInLevel("BitmapItem04", 200, 205);
			_displayManager.createItemInLevel("BitmapItem04", 250, 210);
			_displayManager.createItemInLevel("BitmapItem04", 300, 203);
			
			//createItemInSlot(item id, slot id);
			_displayManager.createItemInSlot("BitmapItem01", "i1");
			_displayManager.createItemInSlot("BitmapItem01", "i4");
			_displayManager.createItemInSlot("BitmapItem04", "i9");
			
			// items created
			
			
			trace("InventorySystem READY \r");
		}
		
	}
	
}