package com.ataroa.mail.model.vo
{
	import com.ataroa.mail.controller.NotifierMailKO;
	import com.ataroa.mail.controller.NotifierMailOK;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class MailProxy extends Proxy implements IProxy
	{
		
		import mx.rpc.remoting.RemoteObject;
		
		static private var _remoteService:RemoteObject;
		
		static public var NAME:String = "MailProxy";
		
		static public const NOTIFIER_MAIL_OK:String = "Notifier un mail en SUCCES"
		static public const NOTIFIER_MAIL_KO:String = "Notifier un mail en ERREUR"
		
		public var needConfirm:Boolean = true; 
		
		public function MailProxy(data:Object=null)
		{
			super(NAME, data);
			
			facade.registerCommand( NOTIFIER_MAIL_OK, NotifierMailOK );
			facade.registerCommand( NOTIFIER_MAIL_KO, NotifierMailKO );
			
		}
		
		override public function onRegister():void
		{
			_remoteService = new RemoteObject();
            _remoteService.destination = "amfphp";
            _remoteService.source ="MailServices";            
            
            _remoteService.addEventListener(FaultEvent.FAULT, faultHandler);
            _remoteService.addEventListener(ResultEvent.RESULT, resultHandler);
            
		}
		
		
		
		private function faultHandler(event:FaultEvent):void{
			
			trace(event.message);
		}
		
		private function resultHandler(e:ResultEvent):void{
			
			if(!this.needConfirm) return;
			
			if( e.result ) this.sendNotification( NOTIFIER_MAIL_OK );
			else this.sendNotification( NOTIFIER_MAIL_KO );		
		}
	
		
		public function sendMail(mail:mailVO):void{
			
			this.needConfirm = mail.needConfirmation;
			_remoteService.sendMail(mail);
		}
		
	}
}