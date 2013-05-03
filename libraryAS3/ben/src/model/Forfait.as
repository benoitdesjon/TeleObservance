package src.model
{
	import src.model.constante.EnumForfait;

	public class Forfait
	{
		private var forfait:EnumForfait;
		
		public function Forfait()
		{
			forfait = new EnumForfait();
		}
		
		/*setters and getters*/
		public function setForfait_91(date:String):void
		{
			forfait.forfait_91 = date;
		}
		
		public function setForfait_92(date:String):void
		{
			forfait.forfait_92 = date;
		}
		
		public function setForfait_93(date:String):void
		{
			forfait.forfait_93 = date;
		}
		
		public function setForfait_XX(date:String):void
		{
			forfait.forfait_XX = date;
		}
		
		public function getForfait_91():String
		{
			return forfait.forfait_91;
		}
		
		public function getForfait_92():String
		{
			return forfait.forfait_92;
		}
		
		public function getForfait_93():String
		{
			return forfait.forfait_93;
		}
		
		public function getForfait_XX():String
		{
			return forfait.forfait_XX;
		}
	}
}