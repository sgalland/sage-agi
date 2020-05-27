package sage.agi.logic.commands;

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
	public static function set_string(n:UInt, m:UInt) {
		var message = LogicProcessor.currentLogic.getMessage(m - 1);
		AGIInterpreter.instance.STRINGS[n] = message;
	}

	// TODO: Implement string commands
}
