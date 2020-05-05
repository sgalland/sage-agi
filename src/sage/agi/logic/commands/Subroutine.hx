package sage.agi.logic.commands;

/**
	Implementation of Subroutine call commands.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Subroutine_call_commands
**/
class Subroutine {
	/**
		Calls a Logic file for execution.
		@param resourceID
	**/
	public static function call(resourceID:UInt) {
		LogicProcessor.execute(resourceID);
	}

	// TODO: Implement Subroutine call commands
}
