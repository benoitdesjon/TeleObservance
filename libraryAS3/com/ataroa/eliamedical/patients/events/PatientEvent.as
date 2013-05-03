package com.ataroa.eliamedical.patients.events
{
	import flash.events.Event;

	public class PatientEvent extends Event
	{
		public static const EVENT_DELETE_ELEMENT:String = "supprimer un element";
		public static const EVENT_EDITER_ELEMENT:String = "editer un element";
		public static const EVENT_FILTRER_LISTE:String = "filtrer la liste des patients";
		
		public var idPatient:String;
		
		public function PatientEvent(type:String, id:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.idPatient = id;
		}
		
	}
}