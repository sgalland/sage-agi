package sage.agi.logic.commands;

import sage.agi.logic.LogicProcessor.Args;
import sage.agi.resources.AGILogic;
import sage.agi.interpreter.AGIInterpreter;

/**
	Commands to work with managing strings.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#String_management_commands
**/
class String {
	/**
		Stores logic message m in string variable n.
		@param n ID of the string variable.
		@param m Index of the message to load.
	**/
	public static function set_string(args:Args) {
		var message = args.logic.getMessage(args.arg2 - 1);
		AGIInterpreter.instance.STRINGS[args.arg1] = message;
	}

	// TODO: Implement string commands
}
