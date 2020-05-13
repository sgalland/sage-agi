package sage.agi.logic.commands;

import sage.agi.interpreter.AGIInterpreter;
import sage.agi.menu.Menu;

/**
	Commands to work with managing menus.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Menu_management_commands
**/
class Menu {
	public static function set_menu(n:UInt) {
		var message = LogicProcessor.currentLogic.getMessage(n - 1); // AGI messages start at 1, not 0. Offset the messageID by -1.

		if (AGIInterpreter.instance.MENU_HEAD == null) {
			AGIInterpreter.instance.MENU_HEAD = new sage.agi.menu.Menu(message);

			if (AGIInterpreter.instance.MENU_TAIL == null)
				AGIInterpreter.instance.MENU_TAIL = AGIInterpreter.instance.MENU_HEAD;
		} else {
			AGIInterpreter.instance.MENU_HEAD.next = new sage.agi.menu.Menu(message);
		}
	}

	public static function submit_menu() {
		AGIInterpreter.instance.MENU_HEAD.modifiable = false;
		AGIInterpreter.instance.MENU_HEAD = AGIInterpreter.instance.MENU_HEAD.next;
	}

	// TODO: Implement menu commands
}
