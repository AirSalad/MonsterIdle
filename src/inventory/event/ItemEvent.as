package
{
	import src.inventory.display.item.DefaultItem;
	import flash.events.Event;
	
	public class ItemEvent extends Event
	{
		public static const UPDATED = "updated";
		public static const ITEM_PICKED_UP = "itemPickedUp";
		public static const ITEM_DROPPED = "itemDropped";
		
		public var item:DefaultItem;
		
		public function ItemEvent(type:String, $item:DefaultItem = null)
		{
			super(type);
			item = $item;
		}
		
	}
}
