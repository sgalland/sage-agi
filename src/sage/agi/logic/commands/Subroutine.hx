package sage.agi.logic.commands;

import sage.agi.resources.AGILogic;
import sage.agi.interpreter.AGIInterpreter;

/**
	Implementation of Subroutine call commands.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Subroutine_call_commands
**/
class Subroutine {
	/**
		Calls a Logic file for execution. If the resource is not loaded, it is temporarily loaded,
		executed, and discarded immediately after execution.
		@param n ID of the resource to execute.
	**/
	public static function call(n:UInt) {
		var logic:AGILogic = AGIInterpreter.instance.LOGICS.get(n);
		if (logic == null)
			Resource.load_logic(n);

		LogicProcessor.execute(n);
		if (logic == null)
			AGIInterpreter.instance.LOGICS.set(n, null);
	}

	/**
		Execute a logic with Resource ID stored in variable n.
		 @param n Variable location of the stored Resource ID.
	**/
	public static function call_v(n:UInt) {
		var resourceID = AGIInterpreter.instance.VARIABLES[n];
		call(resourceID);
	}

	// TODO: Implement Subroutine call commands
}
