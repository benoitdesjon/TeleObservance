package com.ataroa.eliamedical.patients.model.vo
{
	import com.ataroa.eliamedical.patients.events.PatientEvent;
	
	
  
      
    [RemoteClass(alias="VisiteVO")]      
    [Bindable]  
    public class VisiteVO  
    {  
    	
    static public const DEFAULT_TYPE:String = "Installation"
  
    public var id:String;
	public var idPatient:String;
	public var dateVisite:String;
	public var typeVisite:String = "Installation";
	public var lieuPrescription:String;
	public var prescription:String;
	public var details:String;
	public var appareils:Array;
	public var oldappareils:String = ""; 
	public var masque:String;
	public var ns_masque:String;
	public var oldmasque:String = "";
	public var IAHResiduel:String;
	public var P90:String;
	public var utilisationMoyenne:String;
	public var fuiteMasque:String;
	public var epworth:String;
	public var oxymetrie:String;
	public var oxymetrieNocturne:String;
	public var oxymetrieNocturne_url:String;
	public var observance:String;
	public var observance_url:String;
	public var commentaire:String;
	public var active:String;
	
  
  
        public function VisiteVO()  
        {  
              
        }  
        
           public function toString():String{
        	
        	
        	var s:String = "";
        	s+= "[VisiteVO]\n";
        	s+= "observance : " + this.observance + "\n";
        	s+= "observance url : " + this.observance_url + "\n";
        	//s+= "observance file: " + this.observance_fichier + "\n";
        	s+= "oxymetrieNocturne : " + this.oxymetrieNocturne + "\n";
        	s+= "oxymetrieNocturne url : " + this.oxymetrieNocturne_url + "\n";
        	//s+= "oxymetrieNocturne file : " + this.oxymetrieNocturne_fichier + "\n";
        	s+= " active : " + this.active;
        	s+= "[FIN VisiteVO]\n";
        	
        	return s;
        	
        }
        
        
        public function isPrescription( s:String ) : Boolean{
        	
        	var p:RegExp = new RegExp( s );
        	return ( this.prescription.search( p ) > -1 ) ? true : false;
        }
  
  
          
    }  
}  
