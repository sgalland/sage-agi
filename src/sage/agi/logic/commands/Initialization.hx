package sage.agi.logic.commands;

import sys.FileSystem;
import sys.io.FileOutput;
import sys.io.File;
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
		var scancode = 256 * args.arg1 + args.arg2; // this is little endian I am pretty sure

		var event = new EventType(args.arg2, args.arg3);
		AGIInterpreter.instance.EVENT_TYPES.push(event);
	}

	/**
		Sets an abbreviated identifier called the game id. Typically this was a two character code but it wasn't always.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Internals#Game_IDs_and_loaders

		@param arg1 Message ID in the Logic to set as the game id.
	**/
	public static function set_game_id(args:Args) {
		var message = args.logic.getMessage(args.arg1 - 1);
		AGIInterpreter.instance.GAME_ID = message;
	}

	/**
		Sets the visual parameters of the built in debugger. This must be called prior to trace.on being called.
		@see http://www.sierrahelp.com/AGI/AGIStudioHelp/Logic/DebuggingCommands/trace.info.html

		@param arg1 Logic Resource ID.
		@param arg2 Top line number
		@param arg3 Height of the debugger window
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

	/**
		Enables the debugger.
	**/
	public static function trace_on() {
		AGIInterpreter.instance.DEBUGGER_SETTINGS.enabled = true;
	}

	/**
		Logs a message to LOGFILE.
		@param arg1 Message ID to load.
	**/
	public static function log(args:Args) {
		var message:std.String = args.logic.getMessage(args.arg1 - 1);
		#if sys
		var fileName:std.String = "LOGFILE";
		var output:FileOutput = File.append(fileName, false);
		output.writeString('Room ${AGIInterpreter.instance.VARIABLES[0]} Input Line <input line> ${message}');
		output.close();
		#end
	}
}
