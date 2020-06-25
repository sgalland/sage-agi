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
		object.viewFlags |= ViewFlags.OBSERVE_OBJECTS;
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

	/**
		Sets the View Object to be able to update its animation.
		@param arg1 View Object ID to start updates on.
	**/
	public static function start_update(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags |= UPDATE;
	}

	/**
		Forces the View Object to be redrawn without waiting for the end of the interpreter cycle.
		@param arg1 View Object to update
	**/
	public static function force_update(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		update_animations();
	}

	/**
		Defines a block region that View Objects cannot enter unless they are ignoring blocks.
		@param arg1 x1 coordinate
		@param arg2 y1 coordinate
		@param arg3 x2 coordinate
		@param arg4 y2 coordinate
	**/
	public static function block(args:Args) {
		AGIInterpreter.instance.OBJECT_BLOCK.x1 = args.arg1;
		AGIInterpreter.instance.OBJECT_BLOCK.y1 = args.arg2;
		AGIInterpreter.instance.OBJECT_BLOCK.x2 = args.arg3;
		AGIInterpreter.instance.OBJECT_BLOCK.y2 = args.arg4;
	}

	/**
		Removes the defined View Object block.
	**/
	public static function unblock() {
		AGIInterpreter.instance.OBJECT_BLOCK.x1 = 0;
		AGIInterpreter.instance.OBJECT_BLOCK.y1 = 0;
		AGIInterpreter.instance.OBJECT_BLOCK.x2 = 0;
		AGIInterpreter.instance.OBJECT_BLOCK.y2 = 0;
	}

	/**
		Sets the View Object to not pass through the area defined by the block() command.
		@param arg1 View Object ID
	**/
	public static function observe_blocks(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags |= OBSERVE_BLOCKS;
	}

	/**
		Sets the View Object to ignore the area defined by the block() command and can pass through it.
		@param arg1 View Object ID
	**/
	public static function ignore_blocks(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags &= ~OBSERVE_BLOCKS;
	}

	/**
		Allows the View Object to go past the horizon.
		@param arg1 View Object ID
	**/
	public static function ignore_horizon(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags &= ~OBSERVE_HORIZON;
	}

	/**
		Prevents the View Object from passing into the horizon.
		@param arg1 View Object ID
	**/
	public static function observe_horizon(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags |= OBSERVE_HORIZON;
	}

	/**
		Indicates that the View Object is on water.
		@param arg1 View Object ID
	**/
	public static function object_on_water(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags |= VIEW_ON_WATER;
	}

	/**
	    Indicates that the View Object is on land and cannot touch water (priority 3).
	    @param arg1 View Object ID
	**/
	public static function object_on_land(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags |= VIEW_ON_LAND;
	}

	/**
	    Removes movement restrictions on the View Object set by object.on.land and object.on.water
	    @param arg1 View Object ID
	**/
	public static function object_on_anything(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags &= ~VIEW_ON_WATER | ~VIEW_ON_LAND; // TODO: Verify both flags are removed.
	}

	/**
		Update all view objects animation cycles.
	**/
	private static function update_animations() {
		for (key => object in AGIInterpreter.instance.OBJECTS.keyValueIterator()) {
			// TODO: Update cel changes in the backbuffer
			// This is from the view that the view object is associated with...
		}
	}

	// TODO: Implement Object Motion Control commands
}
