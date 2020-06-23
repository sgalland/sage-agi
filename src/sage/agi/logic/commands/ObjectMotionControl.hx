package sage.agi.logic.commands;

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

	public static function player_control() {
		AGIInterpreter.instance.ALLOW_PLAYER_CONTROL = true;
	}

	// TODO: Implement Object Motion Control commands
}
