package sage.agi.logic.commands;

import sage.agi.objects.ViewFlags;
import sage.agi.resources.AGIView.ViewObject;
import sage.agi.logic.LogicProcessor.Args;
import sage.agi.interpreter.AGIInterpreter;

/**
	Commands for animating objects.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Object_motion_control_commands
**/
class ObjectMotionControl {
	/**
		Sets the Y axis of the horizon.
		@param n Position on the Y axis.
	**/
	public static function set_horizon(args:Args) {
		AGIInterpreter.instance.SCREEN.horizon = args.arg1;
	}

	/**
		Indicates that the view object treats other view objects as obstacles.
		@param arg1 View Object ID
	**/
	public static function observe_objs(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		trace(object.viewFlags);
		object.viewFlags |= ViewFlags.OBSERVE_OBJECTS;
		trace(object.viewFlags);
	}

	/**
		Removes the flag so that the view object no longer treats other view objects as obstacles.
		@param arg1 View Object ID
	**/
	public static function ignore_objs(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags &= ~ViewFlags.OBSERVE_OBJECTS;
	}

	/**
		Allows Ego to be controlled by keyboard or joystick.
	**/
	public static function player_control() {
		AGIInterpreter.instance.ALLOW_PLAYER_CONTROL = true;
	}

	/**
		View Object is removed from list of updatable objects. Object will remain on the screen but will not do anything.
		@param arg1 View Object ID to stop updates on.
	**/
	public static function stop_update(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags &= ~UPDATE;
	}

	// TODO: Implement Object Motion Control commands
}
