package sage.agi.logic;

import sage.agi.types.AGIByte;

@:enum abstract Event(Int) from Int {
	var NO_EVENT = 0;
	var ASCII_KEY_EVENT = 1;
	var SCAN_KEY_EVENT = 2;
	var MENU_EVENT = 3;
}

/**
	Description of an event. The type of event (whether it is from the keyboard or for a menu item can be determined
	by the controller() command).
**/
class EventType {
	public function new(scancode:AGIByte, eventType:Event) {
		this.scancode = scancode;
		this.eventType = eventType;
	}

	public var scancode:AGIByte;
	public var eventType:Event;
}
