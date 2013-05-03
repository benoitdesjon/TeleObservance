package com.ataroa.mail.controller
{
	import com.ataroa.mail.model.vo.MailProxy;
	import com.ataroa.mail.model.vo.mailVO;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class SendMail extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void
		{
			
			var proxy:MailProxy = facade.retrieveProxy(MailProxy.NAME) as MailProxy;
			
			proxy.sendMail( notification.getBody() as mailVO );
		
		}
		
		
	}
}