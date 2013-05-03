package com.ataroa.eliamedical.patients.view
{
	import com.ataroa.confirmationBox.events.confirmationEvent;
	import com.ataroa.confirmationBox.model.vo.confirmationRequest;
	import com.ataroa.eliamedical.patients.events.VisiteEvent;
	import com.ataroa.eliamedical.patients.model.PatientProxy;
	import com.ataroa.eliamedical.patients.model.vo.PatientVO;
	import com.ataroa.eliamedical.patients.model.vo.VisiteVO;
	import com.ataroa.eliamedical.patients.view.component.ChampFichierJoint;
	import com.ataroa.eliamedical.patients.view.component.FicheVisiteContainer;
	import com.ataroa.eliamedical.patients.view.component.NewVisiteForm;
	
	import elia.masques.model.MasqueProxy;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class ConsultationPatientMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "ConsultationPatientMediator";
		
		public var proxy:PatientProxy;
		
		//public function ConsultationPatientMediator(viewComponent:consultationPatients=null)
		public function ConsultationPatientMediator(viewComponent:FicheVisiteContainer)
		{
			//TODO: implement function
			super(NAME, viewComponent);
			
			this.proxy = facade.retrieveProxy(PatientProxy.NAME) as PatientProxy;
			
			
			setComportement();
		}
		
		
		private function setComportement():void{
			
			this.composant.addEventListener( VisiteEvent.EVENT_DELETE_ELEMENT, onDeleteElement );
			this.composant.addEventListener( VisiteEvent.EVENT_EDITER_ELEMENT, onEditerElement );
			
			
			//this.composant.addEventListener(consultationPatients.EVENT_VISITE_NEW, onNewVisite );
			//this.composant.newVisiteForm.addEventListener(NewVisiteForm.EVENT_CANCEL_NEW_VISITE, onCancelNewVisite)
			
			this.composant.addEventListener(NewVisiteForm.EVENT_ADD_NEW_VISITE, onAddVisite);
			this.composant.addEventListener(VisiteEvent.SAVE, onMajVisite);
			this.composant.newVisiteForm.addEventListener(NewVisiteForm.EVENT_MAJ_VISITE, onMajVisite)
			this.composant.addEventListener(ChampFichierJoint.EVENT_DELETE_FILE,onDeleteFile);
		}
		
		//private function get composant():consultationPatients
		private function get composant():FicheVisiteContainer
        {
            return viewComponent as FicheVisiteContainer;
        }
		
		override public function listNotificationInterests():Array
		{
			//TODO: implement function
			return [
						
						//PatientProxy.EVENT_PATIENT_LOADED,
						PatientProxy.EVENT_PATIENT_LOADING,
						PatientProxy.EVENT_VISITE_SUPPRIMER,
						PatientProxy.EVENT_VISITE_MODIFIEE
						
			
					]
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var patient:PatientVO;
			
			switch(notification.getName()){
				
				case PatientProxy.EVENT_PATIENT_LOADED :
				
				
				patient = notification.getBody() as PatientVO;
				//this.composant.listeVisite = new ArrayCollection(patient.visites);
				//this.composant.currentState = (this.composant.mode == "lectureSeule") ? "lectureSeule" : "";
				
				this.composant.newVisiteForm.resetForm();
				break;
				
				case PatientProxy.EVENT_PATIENT_LOADING :
				//this.composant.visites = null;
				break;
				
				case PatientProxy.EVENT_VISITE_SUPPRIMER:
				this.proxy.supprimerVisite(notification.getBody().toString());
				break;
				
				case PatientProxy.EVENT_VISITE_MODIFIEE:
				patient = notification.getBody() as PatientVO;
				this.composant.listeVisite = new ArrayCollection(patient.visites);
				//this.composant.newVisiteForm.champObservance.visible = true;
				//this.composant.newVisiteForm.champOxymetrieNocturne.visible = true;
				break;
				
				
				
			}
		}
		
		
		private function onDeleteElement( e:VisiteEvent ):void{
			
			
			this.sendNotification(confirmationEvent.OPEN_CONFIRM_BOX, new confirmationRequest("Visite","", PatientProxy.EVENT_VISITE_SUPPRIMER, e.visite.id ) );
			
		}
		
		private function onEditerElement(e:VisiteEvent):void{
			
			this.composant.currentState = 'form_newVisite';
			
			var visite:VisiteVO = e.visite; 
			trace( " VISITE : " + e.visite.id);
			this.composant.newVisiteForm.visite = visite;
			
			
		}
		
		
		
		private function onCancelNewVisite(e:Event):void{
			
			//this.composant.currentState = "";
			proxy.refreshPatient();
		}
		
		private function onAddVisite(e:VisiteEvent):void{
			
			var visite:VisiteVO = e.visite;
			e.visite.idPatient = this.composant.patient.id;
			this.proxy.addVisite(visite);
		}
		
		private function onMajVisite(e:VisiteEvent):void{
			
			var visite:VisiteVO = e.visite;
			proxy.majVisite(visite);
			
		}
		
		private function onDeleteFile(e:Event):void{
			
			trace("onDELETE FILE");
			var champ:ChampFichierJoint = e.target as ChampFichierJoint
			proxy.deleteFile(champ.idVisite, champ.mysqlField);
		}
		
		
	

		
	}
}