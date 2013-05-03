package com.ataroa.events
{
	import flash.events.Event;

	[Bindable]
	public class AtaroaEvent extends Event
	{
		
		
		public var data:Object;
		
		public function AtaroaEvent(type:String,d:Object)
		{
			super(type, true, true);
			this.data = d;
		}
		
	}
}