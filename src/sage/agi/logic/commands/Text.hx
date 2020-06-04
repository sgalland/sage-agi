package sage.agi.logic.commands;

import sage.agi.helpers.AGIColor;
import sage.agi.text.TextAttribute;
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

	/**
		Sets the visual appearance of text on the screen.
		@param fg Foreground color (as a DOS color)
		@param bg Background color (as a DOS color)
	**/
	public static function set_text_attribute(fg:UInt, bg:UInt) {
		AGIInterpreter.instance.TEXT_ATTRIBUTE = new TextAttribute(AGIColor.getColorByDosColor(fg), AGIColor.getColorByDosColor(bg));
	}

	/**
		Prevents the user from typing input via the keyboard.
	**/
	public static function prevent_input() {
		AGIInterpreter.instance.ALLOW_INPUT = false;
	}

	/**
		Displays the status line.
	**/
	public static function status_line_on() {
		AGIInterpreter.instance.SCREEN.displayStatusLine = true;
	}

	/**
		Hides the status line.
	**/
	public static function status_line_off() {
		AGIInterpreter.instance.SCREEN.displayStatusLine = false;
	}

	// TODO: Implement text commands
}
