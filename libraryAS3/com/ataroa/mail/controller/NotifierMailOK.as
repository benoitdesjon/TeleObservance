package com.ataroa.mail.controller
{
	import com.ataroa.mail.view.MailerOkPopup;
	
	import elia.ApplicationFacade;
	
	import flash.events.Event;
	
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class NotifierMailOK extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void
		{
			
			var pop:IFlexDisplayObject = PopUpManager.createPopUp( ApplicationFacade.appli , MailerOkPopup, true);
			PopUpManager.centerPopUp(pop);
			pop.addEventListener("close", closeHandler);
		
		}
		
		
		private function closeHandler(e:Event):void{
			
			PopUpManager.removePopUp(e.currentTarget as IFlexDisplayObject);
			
			
		}
		
		
	}
}