package sage.agi.logic.commands;

import sage.agi.interpreter.AGIInterpreter;

/**
	Logical test commands.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Logical_test_commands
**/
class Test {
	/**
		Test if vn == m
		@param n Left variable
		@param m Right value
		@return Bool
	**/
	public static function equaln(n:UInt, m:UInt):Bool {
		return AGIInterpreter.instance.VARIABLES[n] == m;
	}

	/**
		Test if vn == vm
		@param n Left variable
		@param m Right variable
		@return Bool
	**/
	public static function equalv(n:UInt, m:UInt):Bool {
		return AGIInterpreter.instance.VARIABLES[n] == AGIInterpreter.instance.VARIABLES[m];
	}

	/**
		Test if vn < m
		@param n Left variable
		@param m Right value
		@return Bool
	**/
	public static function lessn(n:UInt, m:UInt):Bool {
		return AGIInterpreter.instance.VARIABLES[n] < m;
	}

	/**
		Test if vn < vm
		@param n Left variable
		@param m Right variable
		@return Bool
	**/
	public static function lessv(n:UInt, m:UInt):Bool {
		return AGIInterpreter.instance.VARIABLES[n] < AGIInterpreter.instance.VARIABLES[m];
	}

	/**
		Test if vn > m
		@param n Left variable
		@param m Right value
		@return Bool
	**/
	public static function greatern(n:UInt, m:UInt):Bool {
		return AGIInterpreter.instance.VARIABLES[n] > m;
	}

	/**
		Test if vn > vm
		@param n Left variable
		@param m Right variable
		@return Bool
	**/
	public static function greaterv(n:UInt, m:UInt):Bool {
		return AGIInterpreter.instance.VARIABLES[n] > AGIInterpreter.instance.VARIABLES[m];
	}

	/**
		Checks if fn is true.
		@param n Flag ID
		@return Bool
	**/
	public static function isset(n:UInt):Bool {
		return AGIInterpreter.instance.FLAGS[n];
	}

	/**
		Checks if flag in vn is true.
		@param n Variable ID
		@return Bool
	**/
	public static function issetv(n:UInt):Bool {
		var flag = AGIInterpreter.instance.VARIABLES[n];
		return AGIInterpreter.instance.FLAGS[flag];
	}

	public static function controller(n:UInt):Bool {
		return AGIInterpreter.instance.EVENT_TYPES[n] != null;
	}

	// TODO: Implement Test and document
}
