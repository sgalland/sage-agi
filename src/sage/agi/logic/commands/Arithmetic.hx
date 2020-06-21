package sage.agi.logic.commands;

import sage.agi.logic.LogicProcessor.Args;
import sage.agi.interpreter.AGIInterpreter;
import sage.core.MathExtender;

/**
	Implementation of AGI Arithmetic commands
	@see <https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Arithmetic_commands>
**/
class Arithmetic {
	/**
		Increments variable n by 1. If the value is 255 or greater, the value is unchanged.
		@param n Variable to increment.
	**/
	public static function increment(n:UInt) {
		if (AGIInterpreter.instance.VARIABLES[n] < 255)
			AGIInterpreter.instance.VARIABLES[n]++;
	}

	/**
		Decrements variable n by 1.  If the value is 0 or less, the value is unchanged.
		@param n Variable to decrement.
	**/
	public static function decrement(n:UInt) {
		if (AGIInterpreter.instance.VARIABLES[n] > 0)
			AGIInterpreter.instance.VARIABLES[n]--;
	}

	/**
		Assigns a value to variable n.
		@param n Variable to assign a value.
		@param value Value to assign to variable n.
	**/
	public static function assign(n:UInt, value:Int) {
		AGIInterpreter.instance.VARIABLES[n] = value;
	}

	/**
		Assigns a variable n to variable m.
		@param n Variable to assign the value.
		@param m Variable to read the value.
	**/
	public static function assignv(n:UInt, m:UInt) {
		AGIInterpreter.instance.VARIABLES[n] = AGIInterpreter.instance.VARIABLES[m];
	}

	/**
		Add the variable by m.
		@param n Variable to add and set.
		@param m Value to add to the variable.
	**/
	public static function addn(n:UInt, m:UInt) {
		AGIInterpreter.instance.VARIABLES[n] = AGIInterpreter.instance.VARIABLES[n] + m;
	}

	/**
		Add variable n by variable m.
		@param n Variable to add and set.
		@param m Variable to add.
	**/
	public static function addv(n:UInt, m:UInt) {
		AGIInterpreter.instance.VARIABLES[n] = AGIInterpreter.instance.VARIABLES[n] + AGIInterpreter.instance.VARIABLES[m];
	}

	/**
		Subtract from variable n the value of variable m.
		@param args.Arg1 Variable to assign the subtracted value.
		@param args.Arg2 Value to subtract from the variable.
	**/
	public static function subn(args:Args) {
		AGIInterpreter.instance.VARIABLES[args.arg1] -= args.arg2;
	}

	/**
		Subtract the variable n by variable m.
		@param n Variable to assign the value to.
		@param m Variable to subtract.
	**/
	public static function subv(n:UInt, m:UInt) {
		AGIInterpreter.instance.VARIABLES[n] = AGIInterpreter.instance.VARIABLES[n] - AGIInterpreter.instance.VARIABLES[m];
	}

	/**
		Indirectly assign m to variable n
		@param n Variable to set.
		@param m Value to set the variable to.
	**/
	public static function lindirectn(n:UInt, m:UInt) {
		// TODO: Test
		var variable1 = AGIInterpreter.instance.VARIABLES[n];
		AGIInterpreter.instance.VARIABLES[variable1] = m;
	}

	/**
		Indirectly assign variable m to variable n
		@param n Variable to get the variable id to set.
		@param m Variable to get the value.
	**/
	public static function lindirectv(n:UInt, m:UInt) {
		// TODO: Test
		var variable1 = AGIInterpreter.instance.VARIABLES[n];
		var variable2 = AGIInterpreter.instance.VARIABLES[m];
		AGIInterpreter.instance.VARIABLES[variable1] = variable2;
	}

	/**
		Indirectly assign variable m to variable n
		@param n Variable to set.
		@param m Value to set the variable to.
	**/
	public static function rindirect(n:UInt, m:UInt) {
		// TODO: Test
		var variable1 = AGIInterpreter.instance.VARIABLES[m];
		var variable2 = AGIInterpreter.instance.VARIABLES[variable1];
		AGIInterpreter.instance.VARIABLES[n] = variable2;
	}

	/**
		Multiply variable n by m.
		@param n Variable to multiply and set.
		@param m Value to multiply by.
	**/
	public static function muln(n:UInt, m:UInt) {
		AGIInterpreter.instance.VARIABLES[n] *= m;
	}

	/**
		Multiply variable n by variable m.
		 @param n Variable to multiply and set.
		 @param m Variable to multiply by.
	**/
	public static function mulv(n:UInt, m:UInt) {
		AGIInterpreter.instance.VARIABLES[n] *= AGIInterpreter.instance.VARIABLES[m];
	}

	/**
		Divide variable n by m.
		@param n Variable to divide and set.
		@param m Value to divide by.
	**/
	public static function divn(n:UInt, m:UInt) {
		AGIInterpreter.instance.VARIABLES[n] /= m;
	}

	/**
		Divide variable n by variable m.
		@param n Variable to divide and set.
		@param m Variable to divide by.
	**/
	public static function divv(n:UInt, m:UInt) {
		AGIInterpreter.instance.VARIABLES[n] /= AGIInterpreter.instance.VARIABLES[m];
	}

	/**
		Generate a random number between n and m. Assign the random number to variable k.
		@param n Minimum random range.
		@param m Maximum random range.
		@param k Variable to store the random number in.
	**/
	public static function random(n:UInt, m:UInt, k:UInt) {
		AGIInterpreter.instance.VARIABLES[k] = MathExtender.random(n, m);
	}
}
