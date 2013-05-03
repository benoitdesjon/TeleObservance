package ben
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	
	public class HistoReadXML
	{
		private var xmlContent:XML;
		private var xmlContent_List:XMLList;
		private var loader:URLLoader = new URLLoader();
		private var UriXmlFile:URLRequest = new URLRequest ("CompanyXYZ-3116--1-20120530-20121130.xml");
		
		public var tabNom:Object;
		
		public function HistoReadXML():void
		{		
			tabNom = new Object();
			loader.load(UriXmlFile);
			loader.addEventListener(Event.COMPLETE, loadingEnd);
			loader.addEventListener(ProgressEvent.PROGRESS, loadingRate);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioerror);
		}
		
		protected function ioerror(event:IOErrorEvent):void
		{
			trace(event.toString());
		}
		
		private function loadingRate(evt:ProgressEvent):void
		{
			trace(evt.bytesLoaded + "/" + evt.bytesTotal);
		}
		
		private function loadingEnd(evt:Event):void
		{
			evt.target.removeEventListener(Event.COMPLETE, loadingEnd);
			xmlContent = new XML( evt.target.data );
			xmlContent_List = xmlContent.elements();
			//adapt this method to any cie you need
			loadinXmlDataRespironics();
		}
		
		private function loadinXmlDataRespironics():void
		{
			//on fixe le namespace du fichier xml 
			var htmlNS:Namespace = xmlContent.namespace();
			default xml namespace  = htmlNS;
			
			var patientList:XMLList = xmlContent_List[3].children();
			
			
			// xml file read
			for each( var patient:XML in patientList )
			{
				var tabDailyUse:Array = new Array();
//				trace("pati : "+patient.@LastName);
				for each(var day:XML in patient..Day){
//					trace("day : " + day.@Start);
//					trace("utili: " + day..Statistic.(@Name=="Total Connected Time"));
					tabDailyUse.push({day : day.@Start.toString(),
						util : day..Statistic.(@Name=="Total Connected Time").toString()});
				}
				tabNom[patient.@LastName.toString()] = tabDailyUse;
					
				tabDailyUse = null;
			}
			
			for (var pat: String in tabNom){
				trace(pat);
				for (var i:int = 0 ; i < tabNom[pat].length ; i++)
					trace(tabNom[pat][i]["day"] +" : " +
						tabNom[pat][i]["util"]);
			}
			
			//reset of the namespace
			default xml namespace = null;
		}
		
		public function getPatientObservance(numPatient:Number):Array
		{
			var res:Array = new Array;

			var patient:String = tabNom[0];
			res = tabNom[patient];
			
			return res;
		}
	}
}