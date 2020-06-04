package sage.agi.logic.commands;

import sage.agi.interpreter.AGIInterpreter;
import sage.agi.screen.ScreenSettings;

/**
	Commands that are not fully understood.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Other_commands_2
**/
class Other {
	/**
		Sets line position on the screen
		@param a Top line of the playing area. Normally set to 1.
		@param b Top of the player input line. Normally set to 22.
		@param c Line where the status bar resides. Normally set to 0.
	**/
	public static function configure_screen(a:UInt, b:UInt, c:UInt) {
		AGIInterpreter.instance.SCREEN = new ScreenSettings(a, b, c);
	}

	// TODO: Implement other commands
}
