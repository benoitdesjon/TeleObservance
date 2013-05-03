package com.ataroa.eliamedical.patients.events
{
	import com.ataroa.eliamedical.patients.model.vo.VisiteVO;
	
	import flash.events.Event;

	public class VisiteEvent extends Event
	{
		
		public static const EVENT_DELETE_ELEMENT:String = "supprimer une visite";
		public static const EVENT_EDITER_ELEMENT:String = "editer une visite";
		public static const EVENT_TOGGLE_ACTIF_ELEMENT:String = "activer/desactiver la visite";
		
		public static const SAVE:String = "sauver une visite";
		public static const ANNULER:String = "annuler les modifications de la visite";
		
		public var visite:VisiteVO;
		
		public function VisiteEvent(type:String, visite:VisiteVO, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.visite = visite;
		}
		
	}
}