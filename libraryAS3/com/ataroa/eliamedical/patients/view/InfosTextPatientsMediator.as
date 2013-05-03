package com.ataroa.eliamedical.patients.view
{
	import com.ataroa.core.ApplicationFacade;
	import com.ataroa.eliamedical.patients.model.PatientProxy;
	import com.ataroa.eliamedical.patients.model.vo.PatientVO;
	
	import mx.controls.Text;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class InfosTextPatientsMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "InfosTextPatientsMediator";
		
		c
		
		public function InfosTextPatientsMediator(viewComponent:Text=null)
		{
			//TODO: implement function
			super(NAME, viewComponent);
			
			this.proxy = facade.retrieveProxy(PatientProxy.NAME) as PatientProxy;
			
			
			
		}
		
		private function get composant():Text
        {
            return viewComponent as Text;
        }
		
		override public function listNotificationInterests():Array
		{
			//TODO: implement function
			return [
						
						PatientProxy.EVENT_PATIENT_LOADED,
						PatientProxy.EVENT_PATIENT_LOADING
			
					]
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName()){
				
				case PatientProxy.EVENT_PATIENT_LOADED :
				var patient:PatientVO = notification.getBody() as PatientVO;
				this.composant.htmlText = "<b>"+patient.civilite + "</b><b> " + patient.nom + "</b><b> "+ patient.prenom+"</b>, naissance <b>"+patient.naissance+"</b>. <b>"+patient.adresse+ "</b> <b>"+ patient.code_postal + "</b> <b>" +patient.ville +"</b>. Tél : <b>"+patient.telephone+"</b><br/> installation <b>"+patient.dateInstallation+"</b>, DEP valable jusqu’au <b>"+patient.dateFinDEP+"</b>, prochaine visite du technicien : <b>"+patient.dateProchaineVisite+"</b>.";
				if(!ApplicationFacade.appli.fichePatient.contains(ApplicationFacade.appli.zoneAlerte) && patient.alerte != null) ApplicationFacade.appli.fichePatient.addChildAt(ApplicationFacade.appli.zoneAlerte,1);
				ApplicationFacade.appli.textAlert.text = patient.alerte;
				trace(">>>>>>>>>>>>> "+patient.haveVisites);
				
				break;
				
				
				case PatientProxy.EVENT_PATIENT_LOADING :
				this.composant.htmlText = "Chargement en cours, merci de patienter";
				if(ApplicationFacade.appli.fichePatient.contains(ApplicationFacade.appli.zoneAlerte)) ApplicationFacade.appli.fichePatient.removeChild(ApplicationFacade.appli.zoneAlerte);
				ApplicationFacade.appli.textAlert.text = "";
				break;
				
			}
		}
		
		
		
		
	}
}