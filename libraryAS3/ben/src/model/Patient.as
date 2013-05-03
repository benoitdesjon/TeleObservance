package src.model
{

	public class Patient
	{
		private var nom:String;
		private var prenom:String;
		private var machine:Machine;
		private var dateInstal:Date;
		private var forfait:Forfait;
		private var calendrierSuivi:Array;
		private var estHospitalise:Boolean;
		
		private static const NB_SEMAINES:int = 52;
		
//		public function Patient()
//		{
//			nom = new String();
//			prenom = new String();
//			machine = new Machine();
//			dateInstal = new Date();
//			forfait = new Forfait();
//			calendrierSuivi = new Array(NB_SEMAINES);
//			estHospitalise = new Boolean;
//			
//			//tstForfait();
//			//tstCalendrierSuivi();
//		}
		
		public function Patient()
		{
		}
		
		//************ Fonction Tests *****************
		private function tstCalendrierSuivi():void
		{
			trace("test", calendrierSuivi.length);
		}
		
		public function tstForfait():void
		{
			trace(forfait.getForfait_91());
			forfait.setForfait_91("date 1");
			trace(forfait.getForfait_91());
			forfait.setForfait_91("date 2");
			trace(forfait.getForfait_91());
			trace(forfait.getForfait_92());
		}

		
		//************Getter and setter *****************
		public function setNom(_nom:String):void
		{
			nom = _nom;
		}
		
		public function getNom():String
		{
			return nom;
		}
		
		public function setPrenom(_prenom:String):void
		{
			prenom = _prenom;
		}
		
		public function getPrenom():String
		{
			return prenom;
		}
		
		public function setMachine(_machine:Machine):void
		{
			machine = _machine;
		}
		
		public function getMachine():Machine
		{
			return machine;
		}
		
		public function setDateInstal(_dateInstal:Date):void
		{
			dateInstal = _dateInstal;
		}
		public function getDateInstal():Date
		{
			return dateInstal;
		}
		
		public function setForfait(_forfait:Forfait):void
		{
			forfait = _forfait;
		}
		
		public function getForfait():Forfait
		{
			return forfait;
		}
		
		public function setCalendrierSuivi(_calendrierSuivi:Array):void
		{
			calendrierSuivi = _calendrierSuivi;
		}
		
		public function getCalendrierSuivi():Array
		{
			return calendrierSuivi;
		}
		
		public function setEstHospitalise(_estHospitalise:Boolean):void
		{
			estHospitalise = _estHospitalise;
		}
		
		public function getEstHospitalise():Boolean
		{
			return estHospitalise;
		}
		
	}
}