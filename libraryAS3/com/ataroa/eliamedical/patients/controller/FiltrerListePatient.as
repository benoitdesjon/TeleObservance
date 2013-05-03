package com.ataroa.eliamedical.patients.controller
{
	import com.ataroa.eliamedical.patients.model.PatientProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class FiltrerListePatient extends SimpleCommand implements ICommand
	{
	
		
		override public function execute(notification:INotification):void
		{
			
			trace("filtrer " + notification.getBody());
			
			//var proxy:PatientProxy = facade.retrieveProxy( PatientProxy.NAME) as PatientProxy;
			//proxy.chargerPatient( notification.getBody().toString() );
			
			
		}
		
	}
}