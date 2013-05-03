package com.ataroa.eliamedical.patients.model.vo
{
	
  
      
    [RemoteClass(alias="OldPrescriptionVO")]      
    [Bindable]  
    public class OldPrescriptionVO  
    {  
  
	    public var id_prescription:String ="";
		public var id_patient:String ="";
		public var installation:String ="";
		public var appareil:String ="";
		public var masque:String ="";
		public var debit_pression:String ="";
		public var utilisation_moyenne:String ="";
		public var oxymetrie:String ="";
		public var epworth:String ="";
		public var aerosol:String ="";
		public var vni:String ="";
		public var ppc:String ="";
		public var liquide:String ="";
		public var concentrateur:String ="";
		public var limite_dep:String ="";
		public var derniere_visite:String ="";
		public var prochaine_visite:String ="";
		public var alerte:String ="";
		
		public function OldPrescriptionVO()  
        {  
             
        }  
        
        public function toString():String{
        	
        	return "OldPrescription ATAROA OBJECT";
        }
        
        
  
  
          
    }  
}  
