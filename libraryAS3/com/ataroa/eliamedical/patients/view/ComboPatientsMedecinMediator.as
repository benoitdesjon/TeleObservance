package com.ataroa.eliamedical.patients.view
{
	import com.ataroa.eliamedical.patients.model.PatientProxy;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.ComboBox;
	import mx.controls.List;
	import mx.events.ListEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class ComboPatientsMedecinMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "ComboPatientsMedecinMediator";
		
		public var proxy:PatientProxy;
		
		public function ComboPatientsMedecinMediator(viewComponent:List=null)
		{
			//TODO: implement function
			super(NAME, viewComponent);
			
			this.proxy = facade.retrieveProxy(PatientProxy.NAME) as PatientProxy;
			
			this.composant.addEventListener(ListEvent.CHANGE,chargerPatient);
			
		}
		
		private function get composant():List
        {
            return viewComponent as List;
        }
		
		override public function listNotificationInterests():Array
		{
			//TODO: implement function
			return [
						
						PatientProxy.EVENT_LISTE_PATIENT_MEDECIN_LOADED,
						PatientProxy.EVENT_LISTE_PATIENT_MEDECIN_LOADING
			
					]
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName()){
				
				case PatientProxy.EVENT_LISTE_PATIENT_MEDECIN_LOADED :
				this.composant.dataProvider = new ArrayCollection( notification.getBody() as Array);
				this.composant.text = "";
				break;
				
				
				case PatientProxy.EVENT_LISTE_PATIENT_MEDECIN_LOADING :
				this.composant.dataProvider = new ArrayCollection();
				this.composant.text = "Chargement en cours ...";
				break;
				
			}
		}
		
		private function chargerPatient(e:Event):void{
			
			this.proxy.chargerPatient( this.composant.selectedItem.id);
			
		}
		
		
	}
}