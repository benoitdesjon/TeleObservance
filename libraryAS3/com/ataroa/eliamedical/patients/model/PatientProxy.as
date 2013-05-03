package com.ataroa.eliamedical.patients.model
{
	
	
	import com.ataroa.core.ApplicationConstantes;
	import com.ataroa.eliamedical.patients.model.vo.PatientVO;
	import com.ataroa.eliamedical.patients.model.vo.VisiteVO;
	
	import elia.ApplicationFacade;
	import elia.medecins.model.MedecinsProxy;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class PatientProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String = "PatientProxy";
		
		public static const EVENT_LISTE_PATIENT_MEDECIN_LOADING:String = "Chargement de la liste des patient du medecin";
		public static const EVENT_LISTE_PATIENT_MEDECIN_LOADED:String = "La liste des patients du medecin est chargée";
		public static const EVENT_PATIENT_LOADING:String = "Chargement du patient demandé";
		public static const EVENT_PATIENT_LOADED:String = "Le patient demandé est chargée";
		
		public static const EVENT_VISITE_SUPPRIMER:String = "supprimer la visite";
		public static const EVENT_VISITE_MODIFIEE:String = "visite modifiée";
		
		private var filtre:String = "";		
		private var remoteService:RemoteObject;
		private var _currentPatient:PatientVO;
		private var medecinsProxy:MedecinsProxy;
		
		public var listePatients:ArrayCollection = new ArrayCollection();
		
		public function PatientProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
			remoteService = new RemoteObject();
           
            medecinsProxy = facade.retrieveProxy( MedecinsProxy.NAME ) as MedecinsProxy;
           
            remoteService.endpoint = ApplicationConstantes.SERVICE_URL;
            remoteService.destination = "amfphp";
            remoteService.source ="Patients";
            
            remoteService.lister.addEventListener( ResultEvent.RESULT , getListResultHandler );
            remoteService.listerPatientsDuMedecin.addEventListener(ResultEvent.RESULT,listerPatientsDuMedecinHandler);
            remoteService.getPatient.addEventListener(ResultEvent.RESULT,chargerPatientHandler);
            remoteService.supprimerVisite.addEventListener(ResultEvent.RESULT,supprimerVisiteHandler);
            remoteService.addVisite.addEventListener(ResultEvent.RESULT,addVisiteHandler);
            remoteService.majVisite.addEventListener(ResultEvent.RESULT,majVisiteHandler);
            remoteService.deleteFile.addEventListener(ResultEvent.RESULT,deleteFileHandler);
            
            remoteService.addEventListener(FaultEvent.FAULT, onFault);
            
            this.listePatients.filterFunction = filtrer;
		}
		
		
		
		
		private function onFault(e:FaultEvent):void{
			
			Alert.show(e.fault.toString());
			trace("FAULT");
			trace(e.fault);
		}
		
//		Lister les patients.
		
		
		private function changeListe(liste:Object):void{
 			
 			this.listePatients.removeAll();
			for each(var doc:Object in liste){
				
				this.listePatients.addItem(doc);
				
			}
			
			this.sendNotification(ApplicationFacade.LISTE_PATIENTS_LOADED,null);			
 			
 		}
 		
 		private function getListResultHandler(event:ResultEvent):void{
			
			trace("getListResultHandler");
			trace(event.result);
			this.changeListe(event.result);
			var liste:Array = event.result as Array;
			this.sendNotification( ApplicationFacade.LISTE_PATIENTS_LOADED,liste);

		}
		
		public function lister(agence:String):void {
			
		    trace("lister from proxypatients")
		    agence = ( ApplicationFacade.connectedUser.id_profil == 2 )? "0":agence;
            this.remoteService.lister(agence);
        
		}
		
		
		public function listerPatientsDuMedecin(id:String):void{
			
			trace("listerPatientsDuMedecin > "+id);
			this.sendNotification(EVENT_LISTE_PATIENT_MEDECIN_LOADING);
			remoteService.listerPatientsDuMedecin(id);		
			
		}
		
		
		private function listerPatientsDuMedecinHandler(e:ResultEvent):void{
			
			trace("listerPatientsDuMedecinHandler")
			var liste:Array = e.result as Array;
			this.sendNotification(EVENT_LISTE_PATIENT_MEDECIN_LOADED,liste);
			
		}

//		Charger Patient

		
		public function refreshPatient():void{
			
			
			
			remoteService.getPatient(this._currentPatient.id);
			
		}
		
		public function chargerPatient(id:String):void{
			
			
			this.sendNotification(EVENT_PATIENT_LOADING);
			remoteService.getPatient(id);
			
			
		}
		
		private function chargerPatientHandler(e:ResultEvent):void{
			
			
			var patient:PatientVO = e.result as PatientVO;
			this._currentPatient = patient;
			this.sendNotification(EVENT_PATIENT_LOADED,patient);	
			
			
		}
		
// SUPPRIMER UNE VISITE

		public function supprimerVisite(idVisite:String):void{
		
			this.remoteService.supprimerVisite(idVisite);	
			
		}
		
		private function supprimerVisiteHandler(e:ResultEvent):void{
		
			var p:MedecinsProxy = facade.retrieveProxy( MedecinsProxy.NAME) as MedecinsProxy;
			p.refreshPatient();
			
		}
		
// AJOUT D'UNE VISITE

		public function addVisite(v:VisiteVO):void{
			
			this.remoteService.addVisite(v);
		}
		
		private function addVisiteHandler(e:ResultEvent):void{
			
			
			this.sendNotification(EVENT_VISITE_MODIFIEE,e.result as PatientVO);
			
			
			var mproxy:MedecinsProxy = facade.retrieveProxy( MedecinsProxy.NAME) as MedecinsProxy;
			
			/*if(mproxy.selectedMedecin.notif == '1'){
				
				trace("notif == 1");
				var mail:mailVO = new mailVO();
				mail.destinataire = this.medecinsProxy.selectedMedecin.email;
				mail.objet = "Une Nouvelle visite - Elia Médical - " + this._currentPatient.nom + " " + this._currentPatient.prenom;
				mail.message = "Cher Docteur,\n\nNous avons le plaisir de vous informer que nous avons déposé sur le site Internet Sécurisé de ELIA MEDICAL une nouvelle visite concernant "+ this._currentPatient.nom + " " + this._currentPatient.prenom +".\nVous avez la possibilité de la consulter dès ce jour.\n\nEn restant à votre entière disposition.\n\nELIA MEDICAL\n\nATTENTION CE MESSAGE EST GENERE AUTOMATIQUEMENT, MERCI DE NE PAS Y REPONDRE DIRECTEMENT\nPour contacter Elia médical utilisez les coordonnées habituelles";
				mail.needConfirmation = false;
				
				//mail.pjURL = ChampFichierJoint(e.target).url;	
				this.sendNotification( ApplicationFacade.SEND_MAIL, mail );	
				
			}else{
				
				trace("notif == 0");
			}*/
			
			
			
				
			
		}
		
// MISE A JOUR D'UNE VISITE

		public function majVisite(v:VisiteVO):void{
			
			v.idPatient = this._currentPatient.id;
			this.remoteService.majVisite(v);
		}
		
		private function majVisiteHandler(e:ResultEvent):void{
			
			
			this.sendNotification(EVENT_VISITE_MODIFIEE,e.result as PatientVO);
			
		}
		
		// Supprimer un fichier joint

		public function deleteFile(idVisite:String, type:String):void{
			
			this.remoteService.deleteFile(idVisite,type);
		}
		
		public function deleteFileHandler(e:ResultEvent):void{
			
			//this.chargerPatient(this._currentPatient.id);	
		}
		

		
// FILTRER LISTE PATIENTS :
		
		private function testConcordance( chaine:String ):Boolean {
			
			var length:int = this.filtre.length;
			if(chaine.toUpperCase().substr(0,length) == this.filtre.toUpperCase() ) return true;
 			return false;	
			
		}
		
		private function filtrer(value:Object):Boolean{
 		
 			if( this.testConcordance( value.nom ) ) return true;
 			else if( this.testConcordance( value.prenom ) ) return true;
 			else if( this.testConcordance( value.telephone ) ) return true ;
 			else if( this.testConcordance( value.code_postal ) ) return true ;
 			else if( this.testConcordance( value.ville ) ) return true ;
 			else return false;	
 		}
 		
 		public function executeFiltre(string:String):void{
 			
 			this.filtre = string;
 			this.listePatients.refresh();
 			this.sendNotification(ApplicationFacade.LISTE_PATIENTS_LOADED,null);	
 			
 		} 		
 	
		
	}
}