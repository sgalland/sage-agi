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

	/**
		Set flag to true, where the flag is stored in a variable.
		@param n Variable location to get the flag location.
	**/
	public static function setv(n:UInt) {
		var flag = AGIInterpreter.variables[n];
		AGIInterpreter.flags[flag] = true;
	}

	/**
		Set flag to false.
		@param n Flag location to set to false.
	**/
	public static function reset(n:UInt) {
		AGIInterpreter.flags[n] = false;
	}

	/**
		Set flag to false, where the flag is stored in a variable.
		@param n Variable location to get the flag to set to false.
	**/
	public static function resetv(n:UInt) {
		var flag = AGIInterpreter.variables[n];
		AGIInterpreter.flags[flag] = false;
	}

	/**
		Toggle flag value.
		@param n Flag location to toggle.
	**/
	public static function toggle(n:UInt) {
		AGIInterpreter.flags[n] = !AGIInterpreter.flags[n];
	}

	/**
		Toggle flag value, where the flag is stored in a variable.
		@param n Variable location to get the flag to set to toggle.
	**/
	public static function togglev(n:UInt) {
		var flag = AGIInterpreter.variables[n];
		AGIInterpreter.flags[flag] = !AGIInterpreter.flags[flag];
	}
}
