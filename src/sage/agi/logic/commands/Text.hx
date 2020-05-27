package sage.agi.logic.commands;

import sage.agi.interpreter.AGIInterpreter;

/**
	Commands to work with text input and display.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Text_management_commands
**/
class Text {
	/**
		Set the cursor for the user input text prompt.
		@param n ID of the message to use as the cursor.
	**/
	public static function set_cursor_char(n:UInt) {
		var message = LogicProcessor.currentLogic.getMessage(n - 1);
		AGIInterpreter.instance.CURSOR = message;
	}

	// TODO: Implement text commands
}
