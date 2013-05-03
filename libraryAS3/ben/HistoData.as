package ben
{
	import mx.collections.ArrayCollection;
	
	import ben.HistoReadXML;
	
	public class HistoData
	{
		private var numPatient:Number = 01635870612;
		[Bindable]
		public var sales:ArrayCollection;
		
		
		public function HistoData()
		{
			//var p:Patient = new Patient("nom", "prenom", new Machine(), new Date());
			var histor:HistoReadXML = new HistoReadXML();
			histor.tabNom.hasOwnProperty();
			sales = new ArrayCollection(histor.getPatientObservance(numPatient));
			
//			sales = new Array([
//				{ Day:"1", DailyUse:"6.9" },
//				{ Day:"2", DailyUse:"3.8" },
//				{ Day:"3", DailyUse:"4.4" },
//				{ Day:"4", DailyUse:"3.3" },
//				{ Day:"5", DailyUse:".2"  },
//				{ Day:"6", DailyUse:"5.5" },
//				{ Day:"7", DailyUse:"7.0" },
//				{ Day:8,  DailyUse:3.5 },
//				{ Day:9,  DailyUse:3.8 },
//				{ Day:10, DailyUse:.4 },
//				{ Day:11, DailyUse:6.9},
//				{ Day:12, DailyUse:3.8},
//				{ Day:13, DailyUse:4.4},
//				{ Day:14, DailyUse:3.3},
//				{ Day:15, DailyUse:0  },
//				{ Day:16, DailyUse:5.5},
//				{ Day:17, DailyUse:.7 },
//				{ Day:18, DailyUse:3.5},
//				{ Day:19, DailyUse:3.8},
//				{ Day:20, DailyUse:0  },
//				{ Day:21, DailyUse:6.9},
//				{ Day:22, DailyUse:3.8},
//				{ Day:23, DailyUse:4.4},
//				{ Day:24, DailyUse:3.3},
//				{ Day:25, DailyUse:2  },
//				{ Day:26, DailyUse:5.5},
//				{ Day:27, DailyUse:7  },
//				{ Day:28, DailyUse:3.5}
//			]);
		}
	}
	}