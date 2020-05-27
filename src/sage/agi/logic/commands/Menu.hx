package sage.agi.logic.commands;

import sage.agi.types.AGIByte;
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
			AGIInterpreter.instance.MENU.add(new sage.agi.menu.Menu(message));
		}
	}

	/**
		Creates a submenu item and sets the header from the logic strings and the control code (between 0 and 255).
		@param n ID of the logic string
		@param c ID of the control code.
	**/
	public static function set_menu_item(n:UInt, c:AGIByte) { // TODO: Document
		if (!submitted) {
			var message = LogicProcessor.currentLogic.getMessage(n - 1);
			AGIInterpreter.instance.MENU.last().items.push(new sage.agi.menu.MenuItem(message, c));
		}
	}

	/**
		Ends menu creation.
	**/
	public static function submit_menu() {
		submitted = true;
	}

	/**
		Enables a menu item based on the control code.
		@param c Control code associated with the menu.
	**/
	public static function enable_item(c:AGIByte) {
		for (menu in AGIInterpreter.instance.MENU) {
			for (menuItem in menu.items) {
				if (menuItem.controlCode == c)
					menuItem.enabled = true;
			}
		}
	}

	/**
		Disables a menu item based on the control code.
		@param c Control code associated with the menu.
	**/
	public static function disable_item(c:AGIByte) {
		for (menu in AGIInterpreter.instance.MENU) {
			for (menuItem in menu.items) {
				if (menuItem.controlCode == c)
					menuItem.enabled = false;
			}
		}
	}

	/**
		If f14 is set, display the menu system on the screen.
	**/
	public static function menu_input() {
		AGIInterpreter.instance.MENU_VISIBLE = AGIInterpreter.instance.FLAGS[14];
	}
}
