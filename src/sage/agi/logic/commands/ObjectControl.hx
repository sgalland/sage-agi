package sage.agi.logic.commands;

import sage.agi.resources.AGIView.ViewObject;
import sage.agi.interpreter.AGIInterpreter;

/**
	Implementation of Object control commands
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Object_control_commands
**/
class ObjectControl {
	/**
		Sets the position of an undisplayed object on the screen.
		@param n Indicates what object is being set.
		@param x Position on the X axis
		@param y Position on the Y axis
	**/
	public static function position_v(n:UInt, x:UInt, y:UInt) {
		var viewObject:ViewObject = AGIInterpreter.instance.OBJECTS.get(n);
		viewObject.x = x;
		viewObject.y = y;
	}

	// TODO: Implement Object Control commands
}
