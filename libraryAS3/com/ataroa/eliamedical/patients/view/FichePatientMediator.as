package com.ataroa.eliamedical.patients.view
{
	import com.ataroa.ataroaGUI.PopUpChooser;
	import com.ataroa.core.ApplicationConstantes;
	import com.ataroa.eliamedical.patients.model.PatientProxy;
	import com.ataroa.eliamedical.patients.model.vo.PatientVO;
	import com.ataroa.events.AtaroaEvent;
	
	import elia.ApplicationFacade;
	import elia.appareils.view.AppareilsSelectorMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class FichePatientMediator extends Mediator implements IMediator
	{
		
		public var proxy:PatientProxy;
		
		public function FichePatientMediator(mediatorName:String=null, viewComponent:FichePatient=null)
		{
			super(mediatorName, viewComponent);
			this.proxy = facade.retrieveProxy(PatientProxy.NAME) as PatientProxy;
			
			
			
		}
		
		public function get composant():FichePatient
		{
			return this.viewComponent as FichePatient;
		}
		
		
		override public function listNotificationInterests():Array
		{
			
			return [
						
						PatientProxy.EVENT_PATIENT_LOADED,
						PatientProxy.EVENT_PATIENT_LOADING
			
					]
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName()){
				
				
				
				case PatientProxy.EVENT_PATIENT_LOADED :
				
					this.composant.patient = notification.getBody() as PatientVO;
					this.sendNotification(ApplicationConstantes.CHANGE_VIEW,ApplicationConstantes.VIEW_FICHEPATIENT);
				break;
				
				
				case PatientProxy.EVENT_PATIENT_LOADING :
					this.composant.patient = new PatientVO();
				break;
				
			}
		}
		
		
		
		private function onSendMail(e:AtaroaEvent):void{
			
			
			this.sendNotification(ApplicationFacade.SEND_MAIL, e.data);
		}
	}

}