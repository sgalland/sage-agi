package sage.agi.logic.commands;

import sage.agi.logic.LogicProcessor.Args;
import sage.agi.resources.AGILogic;
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
	public static function set_key(args:Args) {
		// TODO: Finish documentation and logic for this function. I am not even sure it's correct.
		var scancode = (args.arg2 << 8) + args.arg1;

		var event = new EventType(scancode, args.arg3);
		AGIInterpreter.instance.EVENT_TYPES.push(event);
	}

	/**
		Sets an abbreviated identifier called the game id. Typically this was a two character code but it wasn't always.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Internals#Game_IDs_and_loaders

		@param n Message ID in the Logic to set as the game id.
		@param l Logic passed to the interpreter.
	**/
	public static function set_game_id(args:Args) {
		var message = args.logic.getMessage(args.arg1 - 1);
		AGIInterpreter.instance.GAME_ID = message;
	}

	/**
		Sets the visual parameters of the built in debugger. This must be called prior to trace.on being called.
		@see http://www.sierrahelp.com/AGI/AGIStudioHelp/Logic/DebuggingCommands/trace.info.html

		@param n Logic Resource ID.
		@param m Top line number
		@param l Height of the debugger window
	**/
	public static function trace_info(args:Args) {
		AGIInterpreter.instance.DEBUGGER_SETTINGS.resourceID = args.arg1;
		AGIInterpreter.instance.DEBUGGER_SETTINGS.topLine = args.arg2;
		AGIInterpreter.instance.DEBUGGER_SETTINGS.height = args.arg3;
	}

	/**
		Sets the size of the script table in bytes.
		@param n Size of the script table to allocate.
	**/
	public static function script_size(args:Args) {
		ScriptTable.instance.setSize(args.arg1);
	}
}
