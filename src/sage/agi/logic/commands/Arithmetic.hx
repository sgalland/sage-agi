package sage.agi.logic.commands;

import sage.agi.interpreter.AGIInterpreter;
import sage.core.MathExtender;

/**
	Implementation of AGI Arithmetic commands
	@see <https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Arithmetic_commands>
**/
class Arithmetic {
	/**
		Increments a variable location by 1. If the value is 255 or greater, the value is unchanged.
		@param variableID ID of the variable to increment.
	**/
	public static function increment(variableID:UInt) {
		if (AGIInterpreter.variables[variableID] < 255)
			AGIInterpreter.variables[variableID]++;
	}

	/**
		Decrements a variable location by 1.  If the value is 0 or less, the value is unchanged.
		@param variableID ID of the variable to decrement.
	**/
	public static function decrement(variableID:UInt) {
		if (AGIInterpreter.variables[variableID] > 0)
			AGIInterpreter.variables[variableID]--;
	}

	/**
		Assigns a value to a variable location.
		@param variableID ID of the variable to assign a value.
		@param value Value to assign to the variable location.
	**/
	public static function assign(variableID:UInt, value:Int) {
		AGIInterpreter.variables[variableID] = value;
	}

	/**
		Assigns a variable2 to variable1.
		@param variableID ID of the variable to assign the value.
		@param variableID2 ID of the variable to read the value.
	**/
	public static function assignv(variableID:UInt, variableID2:UInt) {
		AGIInterpreter.variables[variableID] = AGIInterpreter.variables[variableID2];
	}

	/**
		Add the variable by m.
		@param varableID ID of the variable to add.
		@param m Value to add to the variable.
	**/
	public static function addn(varableID:UInt, m:UInt) {
		AGIInterpreter.variables[varableID] = AGIInterpreter.variables[varableID] + m;
	}

	/**
		Add the variable by variable 2.
		@param varableID ID of the variable to assign the added value.
		@param variableID2 ID of the variable to add.
	**/
	public static function addv(variableID:UInt, variableID2:UInt) {
		AGIInterpreter.variables[variableID] = AGIInterpreter.variables[variableID] + AGIInterpreter.variables[variableID2];
	}

	/**
		Subtract from the variable the value of m.
		@param variableID ID of the variable to assign the subtracted value.
		@param m Value to subtract from the variable.
	**/
	public static function subn(variableID:UInt, m:UInt) {
		AGIInterpreter.variables[variableID] = AGIInterpreter.variables[variableID] + m;
	}

	/**
		Subtract the variable by variable 2.
		@param varableID ID of the variable to assign the value to.
		@param variableID2 ID of the variable to subtract.
	**/
	public static function subv(varableID:UInt, variableID2:UInt) {
		AGIInterpreter.variables[varableID] = AGIInterpreter.variables[varableID] - AGIInterpreter.variables[variableID2];
	}

	/**
		Indirectly assign m to variable n
		@param n ID of the variable to set.
		@param m Value to set the variable to.
	**/
	public static function lindirectn(n:UInt, m:UInt) {
		// TODO: Test
		// TODO: Fix the casts. This is a hack to get rid of an error from direct assignment.
		var variable1 = Std.int(Std.parseFloat(Std.string(AGIInterpreter.variables[n])));
		AGIInterpreter.variables[variable1] = m;
	}

	/**
		Indirectly assign variable m to variable n
		@param n ID of the variable to get the variable id to set.
		@param m Id of the variable to get the value.
	**/
	public static function lindirectv(n:UInt, m:UInt) {
		// TODO: Test
		// TODO: Fix the casts. This is a hack to get rid of an error from direct assignment.
		var variable1 = Std.int(Std.parseFloat(Std.string(AGIInterpreter.variables[n])));
		var variable2 = AGIInterpreter.variables[m];
		AGIInterpreter.variables[variable1] = variable2;
	}

	/**
		Indirectly assign variable m to variable n
		@param n ID of the variable to set.
		@param m Value to set the variable to.
	**/
	public static function rindirect(n:UInt, m:UInt) {
		// TODO: Test
		// TODO: Fix the casts. This is a hack to get rid of an error from direct assignment.
		var variable1 = Std.int(Std.parseFloat(Std.string(AGIInterpreter.variables[m])));
		var variable2 = AGIInterpreter.variables[variable1];
		AGIInterpreter.variables[n] = variable2;
	}

	/**
		Multiply variable n by m.
		@param n ID of the variable to multiply and set.
		@param m Value to multiply by.
	**/
	public static function muln(n:UInt, m:UInt) {
		AGIInterpreter.variables[n] *= m;
	}

	/**
		Multiply variable n by variable m.
		 @param n ID of the variable to multiply and set.
		 @param m ID of the variable to multiply by.
	**/
	public static function mulv(n:UInt, m:UInt) {
		AGIInterpreter.variables[n] *= AGIInterpreter.variables[m];
	}

	/**
		Divide variable n by m.
		@param n ID of the variable to divide and set.
		@param m Value to divide by.
	**/
	public static function divn(n:UInt, m:UInt) {
		AGIInterpreter.variables[n] /= m;
	}

	/**
		Divide variable n by variable m.
		@param n ID of the variable to divide and set.
		@param m ID of the variable to divide by.
	**/
	public static function divv(n:UInt, m:UInt) {
		AGIInterpreter.variables[n] /= AGIInterpreter.variables[m];
	}

	/**
		Generate a random number between n and m. Assign the random number t variable k.
		@param n Minimum random range.
		@param m Maximum random range.
		@param k ID of the variable to set.
	**/
	public static function random(n:UInt, m:UInt, k:UInt) {
		AGIInterpreter.variables[k] = MathExtender.random(n, m);
	}

	// TODO: Complete Arithmetic.hx
	// TODO: Complete class documentation
}
