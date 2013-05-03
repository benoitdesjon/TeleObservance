package com.ataroa.eliamedical.patients.view
{
	import com.ataroa.core.ApplicationConstantes;
	import com.ataroa.eliamedical.patients.model.PatientProxy;
	
	import elia.ApplicationFacade;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.TextInput;
	import mx.controls.listClasses.ListBase;
	import mx.events.ListEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class ListePatientsMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "ComboPatientsMedecinMediator";
		
		public var proxy:PatientProxy;
		
		private var champFiltre:TextInput;
		
		public function ListePatientsMediator(viewComponent:ListBase=null)
		{
			//TODO: implement function
			super(NAME, viewComponent);
			
			this.proxy = facade.retrieveProxy(PatientProxy.NAME) as PatientProxy;
			
		
			this.champFiltre = ApplicationFacade.appli.filtrePatient;
			this.composant.addEventListener(ListEvent.ITEM_CLICK,chargerPatient);
			this.champFiltre.addEventListener(Event.CHANGE,filtrerListePatients);
			this.champFiltre.addEventListener(FocusEvent.FOCUS_IN,ouvrirListe);
			
			
		}
		
		private function get composant():ListBase
        {
            return viewComponent as ListBase;
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
					var liste:ArrayCollection = new ArrayCollection( notification.getBody() as Array);
					liste.filterFunction = filtrerNom;
					this.composant.dataProvider = liste;
					break;
				
				case PatientProxy.EVENT_LISTE_PATIENT_MEDECIN_LOADING :
					this.composant.dataProvider = new ArrayCollection();
					break;
				
			
			}
		}
		
		private function filtrerNom(item:Object):Boolean{
			
			if(this.champFiltre.text == "") return true;
			var pattern:RegExp = new RegExp("^"+(this.champFiltre.text).toLowerCase());
			var str:String = (item.nom)? item.nom : "";
			str = str.toLowerCase();
			return (str.search(pattern) == -1)?false:true;
		}
		
		private function chargerPatient(e:ListEvent):void{
			
			
			this.proxy.chargerPatient(e.currentTarget.selectedItem.id);
			
		}
		
		private function filtrerListePatients(e:Event = null):void{
			
			this.composant.dataProvider.refresh();
			
		}
		
		private function ouvrirListe(e:FocusEvent):void{
			
			this.sendNotification(ApplicationConstantes.CHANGE_VIEW,ApplicationConstantes.VIEW_LISTEPATIENT);
			
		}
		
		
	}
}





