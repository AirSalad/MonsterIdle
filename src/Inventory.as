package  
{

	public class Inventory extends Object 
	{
		public var name:String = "Unnamed Item";
        public var count:int = 1;
        public var weight:int = 0;
        public var icon:String = "unnamed.jpg";
		
		public function Inventory(Properties:Object) 
		{ 
            //By passing in an object, we can define only the properties we want to change.
            for (var name:String in Properties) {
                //Only property names that match will overwrite the defaults.
                if (this.hasOwnProperty(name)) {
                    this[name] = Properties[name]
                }
            }
        }
    }
}