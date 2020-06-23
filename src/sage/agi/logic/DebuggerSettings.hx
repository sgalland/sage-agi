package sage.agi.logic;

import sage.agi.types.AGIByte;

/**
	Manages the debugger parameters.
**/
typedef DebuggerSettings = {
	/**
		Resource ID of the logic file with trace commands.
	**/
	@:optional var resourceID:AGIByte;

	/**
		Top line to display the debugger
	**/
	@:optional var topLine:AGIByte;

	/**
		Height of the debugger window.
	**/
	@:optional var height:AGIByte;

	/**
		Indicates the debugger is enabled.
	**/
	@:optional var enabled:Bool;
}
