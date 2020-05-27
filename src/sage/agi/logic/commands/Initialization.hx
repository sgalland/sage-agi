package sage.agi.logic.commands;

import sage.agi.logic.EventType.Event;
import sage.agi.interpreter.AGIInterpreter;
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

		var event = new EventType(scancode, sc);
		AGIInterpreter.instance.EVENT_TYPES.push(event);
	}

	/**
		Sets an abbreviated identifier called the game id. Typically this was a two character code but it wasn't always.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Internals#Game_IDs_and_loaders

		@param n Message ID in the Logic to set as the game id.
	**/
	public static function set_game_id(n:UInt) {
		var message = LogicProcessor.currentLogic.getMessage(n - 1);
		AGIInterpreter.instance.GAME_ID = message;
	}

	/**
		Sets the visual parameters of the built in debugger. This must be called prior to trace.on being called.
		@see http://www.sierrahelp.com/AGI/AGIStudioHelp/Logic/DebuggingCommands/trace.info.html
		
		@param n Logic Resource ID.
		@param m Top line number
		@param l Height of the debugger window
	**/
	public static function trace_info(n:UInt, m:UInt, l:UInt) {
		AGIInterpreter.instance.DEBUGGER_SETTINGS = new DebuggerSettings(n, m, l);
	}

	/**
		Sets the size of the script table in bytes.
		@param n Size of the script table to allocate.
	**/
	public static function script_size(n:UInt) {
		ScriptTable.instance.setSize(n);
	}
}
