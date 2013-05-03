package ben.librairy
{
	public class Ring
	{
		protected var structure:Array ;
		protected var head:int;
		protected var lengthStruct:int;
		
		public function Ring(sizeRing:int){
			lengthStruct = sizeRing;
			structure = new Array(sizeRing);
			//initialisation à -1 pour pouvoir voir quand la structure est pleine
			for(var i:int = 0 ; i < lengthStruct ; i++)
				structure[i] = -1;
			head = 0;
		}
		
		public function add(element:Object):int{
			structure[head] = element;
			head = head%lengthStruct;
			return head;
		}
		
		public function get(position:int):Object{
			if (position > lengthStruct) return "position out of range";
			return structure[position];
		}
		
		public function flush():void{
			structure = new Array(lengthStruct);
			head = 0;
			for(var i:int = 0 ; i < structure ; i++)
				structure[i] = -1;
		}
		
		public function toString():String{
			var res:String;
			
			for(var i:int = 0 ; i < lengthStruct ; i++)
				res += structure[i] + " ";
			
			return res;
		}
	}
}