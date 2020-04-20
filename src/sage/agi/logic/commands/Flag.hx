package sage.agi.logic.commands;

import sage.agi.interpreter.AGIInterpreter;

/**
	Implementation of AGI Flag commands for use in boolean operations.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Flag_commands
**/
class Flag {
	/**
		Set flag n to true.
		@param n Flag to set
	**/
	public static function set(n:UInt) {
		AGIInterpreter.flags[n] = true;
	}

	public static function setv(n:UInt) {
		var flag = AGIInterpreter.variables[n];
		AGIInterpreter.flags[flag] = true;
	}

	public static function reset(n:UInt) {
		AGIInterpreter.flags[n] = false;
	}

	public static function resetv(n:UInt) {
		var flag = AGIInterpreter.variables[n];
		AGIInterpreter.flags[flag] = false;
	}

	public static function toggle(n:UInt) {
		AGIInterpreter.flags[n] = !AGIInterpreter.flags[n];
	}

	public static function togglev(n:UInt) {
		var flag = AGIInterpreter.variables[n];
		AGIInterpreter.flags[flag] = !AGIInterpreter.flags[flag];
	}

	// TODO: Implement Flag Commands
}
