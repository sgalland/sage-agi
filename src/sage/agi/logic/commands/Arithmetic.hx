package sage.agi.logic.commands;

import sage.agi.interpreter.AGIInterpreter;

/**
	Implementation of AGI Arithmetic commands
	@see <https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Arithmetic_commands>
**/
class Arithmetic {
	/**
		Increments a variable location by 1. If the value is 255 or greater, the value is unchanged.
		@param variableID
	**/
	public static function increment(variableID:UInt) {
		if (AGIInterpreter.variables[variableID] < 255)
			AGIInterpreter.variables[variableID]++;
	}

	/**
		Decrements a variable location by 1.  If the value is 0 or less, the value is unchanged.
		@param variableID
	**/
	public static function decrement(variableID:UInt) {
		if (AGIInterpreter.variables[variableID] > 0)
			AGIInterpreter.variables[variableID]--;
	}

	/**
		Assigns a value to a variable location.
		@param variableID
		@param value
	**/
	public static function assign(variableID:UInt, value:Int) {
		AGIInterpreter.variables[variableID] = value;
	}

	/**
		Assigns a variable2 to variable1.
		@param variableID
		@param variableID2
	**/
	public static function assignv(variableID:UInt, variableID2:UInt) {
		AGIInterpreter.variables[variableID] = AGIInterpreter.variables[variableID2];
	}

	/**
		Increment the variable by m.
		@param varableID
		@param m
	**/
	public static function addn(varableID:UInt, m:UInt) {
		AGIInterpreter.variables[varableID] = AGIInterpreter.variables[varableID] + m;
	}

	/**
		Increment the variable by variable 2.
		@param varableID
		@param variableID2
	**/
	public static function addv(variableID:UInt, variableID2:UInt) {
		AGIInterpreter.variables[variableID] = AGIInterpreter.variables[variableID] + AGIInterpreter.variables[variableID2];
	}

	/**
		Subtract from the variable the value of m.
		@param variableID
		@param m
	**/
	public static function subn(variableID:UInt, m:UInt) {
		AGIInterpreter.variables[variableID] = AGIInterpreter.variables[variableID] + m;
	}

	/**
		Subtract the variable by variable 2.
		@param varableID
		@param variableID2
	**/
	public static function subv(varableID:UInt, variableID2:UInt) {
		AGIInterpreter.variables[varableID] = AGIInterpreter.variables[varableID] - AGIInterpreter.variables[variableID2];
	}

	// TODO: Complete Arithmetic.hx
	// lindirectn(n,m)
	// lindirectv(n,m)
	// rindirect(n,m)
	// muln(n,m)
	// mulv(n,m)
	// divn(n,m)
	// divv(n,m)
	// random(n,m,k)
}
