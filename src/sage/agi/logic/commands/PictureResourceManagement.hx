package sage.agi.logic.commands;

import sage.agi.logic.LogicProcessor.Args;
import sage.agi.resources.AGIPicture;
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
	public static function draw_pic(args:Args) {
		var resourceID = AGIInterpreter.instance.VARIABLES[args.arg1];
		var pic:AGIPicture = AGIInterpreter.instance.PICTURES.get(resourceID);
		AGIInterpreter.instance.CURRENT_PIC = pic;
	}

	public static function show_pic() {
		AGIInterpreter.instance.RENDERER.videoBackBuffer = AGIInterpreter.instance.CURRENT_PIC.getPicturePixels();
		AGIInterpreter.instance.RENDERER.priorityBackBuffer = AGIInterpreter.instance.CURRENT_PIC.getPriorityPixels();
	}

	// TODO: Implement PictureResourceManagement
}
