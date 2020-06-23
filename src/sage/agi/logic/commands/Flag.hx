package sage.agi.logic.commands;

import sage.agi.logic.LogicProcessor.Args;
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
	public static function set(args:Args) {
		AGIInterpreter.instance.FLAGS[args.arg1] = true;
	}

	/**
		Set flag to true, where the flag is stored in a variable.
		@param n Variable location to get the flag location.
	**/
	public static function setv(args:Args) {
		var flag = AGIInterpreter.instance.VARIABLES[args.arg1];
		AGIInterpreter.instance.FLAGS[flag] = true;
	}

	/**
		Set flag to false.
		@param n Flag location to set to false.
	**/
	public static function reset(args:Args) {
		AGIInterpreter.instance.FLAGS[args.arg1] = false;
	}

	/**
		Set flag to false, where the flag is stored in a variable.
		@param n Variable location to get the flag to set to false.
	**/
	public static function resetv(args:Args) {
		var flag = AGIInterpreter.instance.VARIABLES[args.arg1];
		AGIInterpreter.instance.FLAGS[flag] = false;
	}

	/**
		Toggle flag value.
		@param n Flag location to toggle.
	**/
	public static function toggle(args:Args) {
		AGIInterpreter.instance.FLAGS[args.arg1] = !AGIInterpreter.instance.FLAGS[args.arg1];
	}

	/**
		Toggle flag value, where the flag is stored in a variable.
		@param n Variable location to get the flag to set to toggle.
	**/
	public static function togglev(args:Args) {
		var flag = AGIInterpreter.instance.VARIABLES[args.arg1];
		AGIInterpreter.instance.FLAGS[flag] = !AGIInterpreter.instance.FLAGS[flag];
	}
}
