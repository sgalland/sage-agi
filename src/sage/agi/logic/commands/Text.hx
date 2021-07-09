package sage.agi.logic.commands;

import sage.agi.logic.LogicProcessor.Args;
import sage.agi.resources.AGILogic;
import sage.agi.helpers.AGIColor;
import sage.agi.text.TextAttribute;
import sage.agi.interpreter.AGIInterpreter;

/**
	Commands to work with text input and display.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Text_management_commands
**/
class Text {
	/**
		How many pixels tall a char is.
	**/
	static var CHAR_ROWS = 8;

	/**
		How many pixels wide a char is.
	**/
	static var CHAR_COLS = 8;

	/**
		Set the cursor for the user input text prompt.
		@param n ID of the message to use as the cursor.
	**/
	public static function set_cursor_char(args:Args) {
		var message = args.logic.getMessage(args.arg1 - 1);
		AGIInterpreter.instance.CURSOR = message;
	}

	/**
		Sets the visual appearance of text on the screen.
		@param fg Foreground color (as a DOS color)
		@param bg Background color (as a DOS color)
	**/
	public static function set_text_attribute(args:Args) {
		AGIInterpreter.instance.TEXT_ATTRIBUTE = new TextAttribute(AGIColor.getColorByDosColor(args.arg1), AGIColor.getColorByDosColor(args.arg2));
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

	/**
		Clears lines n to m with color c.
		@param n Start line
		@param m End line
		@param c Color to use to clear the line.
	**/
	public static function clear_lines(args:Args) {
		var startLine = args.arg1 * CHAR_ROWS;
		var endLine = args.arg2 * CHAR_ROWS;
		// TODO: Draw a rectangle over the area to hide it with the color.
	}

	/**
		Clears a rectangle area from the top left coordinates to the bottom right coordinates using the color c.
		@param x1 Top left
		@param y1 Top row
		@param x2 Bottom right
		@param y2 Bottom row
		@param c Color to clear the region with.
	**/
	public static function clear_text_rect(args:Args) {
		// TODO: Implement clear_text_rect
	}

	public static function display(args:Args) {}

	// TODO: Implement text commands
}
