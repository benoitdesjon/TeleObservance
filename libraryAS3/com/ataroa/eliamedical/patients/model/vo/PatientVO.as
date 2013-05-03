package com.ataroa.eliamedical.patients.model.vo
{
	import elia.alerte.AlerteFinDEP;
	
	
  
      
    [RemoteClass(alias="PatientVO")]      
    [Bindable]  
    public class PatientVO  
    {  
  
  		 
  
        static public const ETAT_ENCOURS:String = "En cours";
        static public const ETAT_ARRETE:String = "Arrêté";
        static public const ETAT_DECEDE:String = "Décédé";
        static public const ETAT_RETARD:String = "Retard";
        
        public var id:String = "";  
        public var civilite:String;
        public var nom:String;  
        public var prenom:String;  
        public var naissance:String;
        public var id_secu:String;
        public var cpam:Object;
        public var mutuelle:Object;
        public var adresse:String;  
        public var code_postal:String;  
        public var ville:String; 
        public var commentaire_adresse:String; 
        public var telephone:String = "";  
        public var telephone2:String = "";
        public var mail:String = "";
        public var dateInstallation:String;
		public var dateFinDEP:String;
		public var dep_transmise:String = '0';
		public var dep_date_transmission:String = '';
		public var dep_transmise_patient:String = '0';
		public var dep_date_transmission_patient:String = '';
		public var dateProchaineVisite:String;
		public var dateRDVMedecin:String;
		public var etat:String = ETAT_ENCOURS;
		public var arret_motif:String;
		public var arret_date:String;
		public var arret_demandeur:String;
		public var arret_demandeur_coordonnees:String;
		public var date_fin_aerosol:String;
		public var num_teleobservance:String;
		
		
		public var alerte:String;
		public var commentaire:String;
		
		public var id_medecin:String;
		public var nom_medecin:String;
		public var adresse_medecin;
		public var observance_by_mail:String;
		
		public var id_agence:String;
		public var nom_agence:String;
		public var ville_agence:String;
		public var raison_sociale_agence;
		public var responsable_agence;
		public var adresse1_agence;
		public var adresse2_agence;
		public var adresse3_agence;
		public var code_postal_agence;
		public var pays_agence;
		
		public var id_technicien:String;
		public var nom_technicien:String;
		
		public var oldPrescription:OldPrescriptionVO;
		public var oldObservance:Object;
		public var visites:Array;
	

  
        public function PatientVO()  
        {  
              this.visites = new Array();
              this.oldPrescription = new OldPrescriptionVO();
        }  
        
        
        public function get haveVisites():Boolean{
        	
        	return (this.visites.length > 0)? true:false;
        	
        	
        }
        
        
        
        public function get finDEPSmiley():Object{
        	
        	return AlerteFinDEP.getAlerteForDate( this.dateFinDEP );
        	
        }
        
        
        
       
  
  
          
    }  
}  
