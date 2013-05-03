package com.ataroa.mail.model.vo
{
	[RemoteClass(alias="MailVO")]      
    [Bindable] 
	public class mailVO
	{
		
		public var destinataire:String;
		public var emetteur:String;
		public var objet:String;
		public var message:String;
		public var pjURL:String;
		public var needConfirmation:Boolean = true;
		
		
		public function mailVO()
		{
		
		}
		
		public function toString():String{
			
			var mail:String = "";
			mail += "[ Object : MAILVO ]\n";
			mail += "Destinataire : " + this.destinataire + "\n";
			mail += "Emetteur  : " + this.emetteur + "\n";
			mail += "Objet : " + this.objet + "\n";
			mail += "Message : \n" + this.message + "\n";
			mail += "Piece Jointe URL : " + this.pjURL + "\n";
			mail += "[ / Object : MAILVO ]\n";
			
			return mail;
		}

	}
}