package sage.agi.logic.commands;

import sage.agi.interpreter.AGIInterpreter;
import sage.agi.menu.Menu;

/**
	Commands to work with managing menus.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Menu_management_commands
**/
class Menu {
	public static function set_menu(n:String) {
		if (AGIInterpreter.instance.MENU == null)
			AGIInterpreter.instance.MENU = new sage.agi.menu.Menu(n);
		else {
			var currentMenu:Menu = null;
			while ((currentMenu = AGIInterpreter.instance.MENU.next) != null) {
				currentMenu = new sage.agi.menu.Menu(n);
			}
		}
	}

	public static function submit_menu(){
		// <some menu item>.modifiable = false;
	}
	// TODO: Implement menu commands
}
