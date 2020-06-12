package sage.agi.logic.commands;

import sage.agi.interpreter.AGIInterpreter;

/**
	Implementaton of commands for working with Pictures.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Picture_resource_management_commands
**/
class PictureResourceManagement {
	/**
		Sets the currently drawn Picture resource.
		@param n Variable ID of the resource number.
	**/
	public static function draw_pic(n:UInt) {
		var resourceID = AGIInterpreter.instance.VARIABLES[n];
		var pic:AGIPicture = AGIInterpreter.instance.PICTURES.get(resourceID);
		AGIInterpreter.instance.CURRENT_PIC = pic;
	}

	// TODO: Implement PictureResourceManagement
}
