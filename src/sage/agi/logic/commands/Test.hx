package sage.agi.logic.commands;

import sage.agi.helpers.AGIColor;
import sage.agi.interpreter.AGIInterpreter;

/**
	Logical test commands.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Logical_test_commands
**/
class Test {
	public static function equaln(n:UInt, m:UInt):Bool {
		return AGIInterpreter.VARIABLES[n] == m;
	}

	public static function equalv(n:UInt, m:UInt):Bool {
		return AGIInterpreter.VARIABLES[n] == AGIInterpreter.VARIABLES[m];
	}

	public static function lessn(n:UInt, m:UInt):Bool {
		return AGIInterpreter.VARIABLES[n] < m;
	}

	public static function lessv(n:UInt, m:UInt):Bool {
		return AGIInterpreter.VARIABLES[n] < AGIInterpreter.VARIABLES[m];
	}

	public static function greatern(n:UInt, m:UInt):Bool {
		return AGIInterpreter.VARIABLES[n] < m;
	}

	public static function greaterv(n:UInt, m:UInt):Bool {
		return AGIInterpreter.VARIABLES[n] > AGIInterpreter.VARIABLES[m];
	}

	public static function isset(n:UInt):Bool {
		return AGIInterpreter.FLAGS[n];
	}

	public static function issetv(n:UInt):Bool {
		var flag = AGIInterpreter.VARIABLES[n];
		return AGIInterpreter.FLAGS[flag];
	}

	// TODO: Implement Test and document
}
