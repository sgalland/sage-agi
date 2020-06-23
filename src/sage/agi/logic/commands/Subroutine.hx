package sage.agi.logic.commands;

import sage.agi.logic.LogicProcessor.Args;
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
		@param args.arg1 ID of the resource to execute.
	**/
	public static function call(args:Args) {
		var logic:AGILogic = AGIInterpreter.instance.LOGICS.get(args.arg1);
		if (logic == null)
			Resource.load_logic(args.arg1);

		var processor = new LogicProcessor();
		processor.execute(args.arg1);
		if (logic == null)
			AGIInterpreter.instance.LOGICS.set(args.arg1, null);
	}

	/**
		Execute a logic with Resource ID stored in variable n.
		 @param n Variable location of the stored Resource ID.
	**/
	public static function call_v(args:Args) {
		var resourceID = AGIInterpreter.instance.VARIABLES[args.arg1];
		args.arg1 = resourceID;
		call(args);
	}

	// TODO: Implement Subroutine call commands
}
