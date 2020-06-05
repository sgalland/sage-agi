package sage.agi.logic.commands;

import sage.agi.objects.ViewFlags;
import sage.agi.resources.AGIView.ViewObject;
import sage.agi.interpreter.AGIInterpreter;

/**
	Implementation of Object control commands
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Object_control_commands
**/
class ObjectControl {
	/**
		Object is included in the list of animatable objects. Objects not in this list are considered non-existant.
		@param n Number of object to load.
	**/
	public static function animate_obj(n:UInt) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(n);
		if (object == null) {
			object = {};
			AGIInterpreter.instance.OBJECTS.set(n, object);
		}
		object.viewFlags = ViewFlags.ANIMATE;
		//TODO: Do we need to set other flags too??
	}

	/**
		Sets the position of an undisplayed object on the screen.
		@param n Indicates what object is being set.
		@param x Position on the X axis
		@param y Position on the Y axis
	**/
	public static function position_v(n:UInt, x:UInt, y:UInt) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(n);
		object.x = x;
		object.y = y;
	}

	// TODO: Implement Object Control commands
}
