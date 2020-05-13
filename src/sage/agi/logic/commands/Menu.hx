package sage.agi.logic.commands;

import sage.agi.interpreter.AGIInterpreter;
import sage.agi.menu.Menu;

/**
	Commands to work with managing menus.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Menu_management_commands
**/
class Menu {
	/**
		Creates a Menu and sets the header.
		@param n Message ID in the logic.
	**/
	public static function set_menu(n:UInt) {
		// TODO: set.menu() should literally create the element and set itself as head, don't wait for submit.menu()
		var message = LogicProcessor.currentLogic.getMessage(n - 1);

		if (AGIInterpreter.instance.MENU_HEAD == null) {
			AGIInterpreter.instance.MENU_HEAD = new sage.agi.menu.Menu(message);
		} else if (AGIInterpreter.instance.MENU_HEAD.next == null) {
			AGIInterpreter.instance.MENU_HEAD.next = new sage.agi.menu.Menu(message);
			AGIInterpreter.instance.MENU_HEAD = AGIInterpreter.instance.MENU_HEAD.next;
		}
	}

	/**
		[Description]
		@param n
		@param c
	**/
	public static function set_menu_item(n:UInt, c:UInt) {
		var message = LogicProcessor.currentLogic.getMessage(n - 1);
		AGIInterpreter.instance.MENU_HEAD.items.push(new sage.agi.menu.MenuItem(message, c));
	}

	public static function submit_menu() {
		// TODO: This is wrong. submit.menu() finalizes all menu creation.
		AGIInterpreter.instance.MENU_HEAD.modifiable = false;
		AGIInterpreter.instance.MENU_HEAD = AGIInterpreter.instance.MENU_HEAD.next;
	}

	// TODO: Implement menu commands
}
