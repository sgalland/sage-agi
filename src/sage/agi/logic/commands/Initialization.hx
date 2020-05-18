package sage.agi.logic.commands;

import sage.agi.types.AGIByte;
import haxe.ds.Vector;

class Initialization {
	/**
		Sets the interpreters special key in the event table.
		@param s Characters ASCII code.
		@param c Keyboard scancode.
		@param sc Interpreters event code.
	**/
	public static function set_key(s:AGIByte, c:AGIByte, sc:AGIByte) {
		// TODO: Finish documentation and logic for this function. I am not even sure it's correct.
		var scancode = (c << 8) + s;

		// add to the EventType table...

	}

	/**
		Sets the size of the script table in bytes.
		@param n Size of the script table to allocate.
	**/
	public static function script_size(n:UInt) {
		ScriptTable.instance.setSize(n);
	}
}
