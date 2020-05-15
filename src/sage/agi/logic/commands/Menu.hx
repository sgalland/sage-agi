package sage.agi.logic.commands;

import sage.agi.interpreter.AGIInterpreter;
import sage.agi.menu.Menu;

/**
	Commands to work with managing menus.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Menu_management_commands
**/
class Menu {
	private static var submitted:Bool;

	/**
		Creates a Menu and sets the header.
		@param n Message ID in the logic.
	**/
	public static function set_menu(n:UInt) {
		if (!submitted) {
			var message = LogicProcessor.currentLogic.getMessage(n - 1);
			AGIInterpreter.instance.menu.add(new sage.agi.menu.Menu(message));
		}
	}

	/**
		[Description]
		@param n
		@param c
	**/
	public static function set_menu_item(n:UInt, c:UInt) { //TODO: Document
		if (!submitted) {
			var message = LogicProcessor.currentLogic.getMessage(n - 1);
			AGIInterpreter.instance.menu.last().items.push(new sage.agi.menu.MenuItem(message, c));
		}
	}

	public static function submit_menu() {
		submitted = true;
	}

	// TODO: Implement menu commands
}
