package sage.agi.logic.commands;

import sage.agi.helpers.AGIColor;
import sage.agi.interpreter.AGIInterpreter;

/**
	Logical test commands.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Logical_test_commands
**/
class Test {
	public static function equaln(n:UInt, m:UInt):Bool {
		return AGIInterpreter.instance.VARIABLES[n] == m;
	}

	public static function equalv(n:UInt, m:UInt):Bool {
		return AGIInterpreter.instance.VARIABLES[n] == AGIInterpreter.instance.VARIABLES[m];
	}

	public static function lessn(n:UInt, m:UInt):Bool {
		return AGIInterpreter.instance.VARIABLES[n] < m;
	}

	public static function lessv(n:UInt, m:UInt):Bool {
		return AGIInterpreter.instance.VARIABLES[n] < AGIInterpreter.instance.VARIABLES[m];
	}

	public static function greatern(n:UInt, m:UInt):Bool {
		#if debug
		trace('v${n} = ${AGIInterpreter.instance.VARIABLES[n]}');
		var result = AGIInterpreter.instance.VARIABLES[n] > m;
		trace("greatern(v" + n + " value:" + AGIInterpreter.instance.VARIABLES[n] + ", " + m + ") == " + result);
		#end
		return AGIInterpreter.instance.VARIABLES[n] > m;
	}

	public static function greaterv(n:UInt, m:UInt):Bool {
		#if debug
		var result = AGIInterpreter.instance.VARIABLES[n] > AGIInterpreter.instance.VARIABLES[m];
		trace("greaterv(v"
			+ n
			+ " value:"
			+ AGIInterpreter.instance.VARIABLES[n]
			+ ", "
			+ AGIInterpreter.instance.VARIABLES[m]
			+ ") == "
			+ result);
		#end
		return AGIInterpreter.instance.VARIABLES[n] > AGIInterpreter.instance.VARIABLES[m];
	}

	public static function isset(n:UInt):Bool {
		return AGIInterpreter.instance.FLAGS[n];
	}

	public static function issetv(n:UInt):Bool {
		var flag = AGIInterpreter.instance.VARIABLES[n];
		return AGIInterpreter.instance.FLAGS[flag];
	}

	public static function controller(n:UInt):Bool {
		return AGIInterpreter.instance.EVENT_TYPES[n] != null;
	}

	// TODO: Implement Test and document
}
