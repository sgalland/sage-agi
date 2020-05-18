package sage.agi.logic;

import sage.agi.types.AGIByte;

@:enum abstract Event(Int) {
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
	public var type:AGIByte;
	public var eventID:AGIByte;
	public var asciiValue:AGIByte;
	public var scanCodeValue:AGIByte;
	public var activated:Bool;
}
