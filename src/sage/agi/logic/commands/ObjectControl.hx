package sage.agi.logic.commands;

import sage.agi.types.AGIByte;
import sage.agi.resources.AGIView;
import sage.agi.logic.LogicProcessor.Args;
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
		@param arg1 Number of object to load.
	**/
	public static function animate_obj(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		if (object == null) {
			object = {};
			AGIInterpreter.instance.OBJECTS.set(args.arg1, object);
		}
		object.viewFlags |= ViewFlags.ANIMATE;
		// TODO: Do we need to set other flags too??
	}

	/**
		Removes all ViewObjects from the list of animatable objects.
	**/
	public static function unanimate_all() {
		AGIInterpreter.instance.OBJECTS.clear();
	}

	/**
		View Object n is associated with View resource number m.
		@param arg1 View Object ID
		@param arg2 View Resource Number
	**/
	public static function set_view(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		var view:AGIView = AGIInterpreter.instance.VIEWS.get(args.arg2);
		object.view = view;
	}

	/**
		View Object n is associated with View resource number stored in vm.
		@param arg1 View Object ID
		@param arg2 Variable containing the View Resource Number
	**/
	public static function set_view_v(args:Args) {
		var viewID:Int = AGIInterpreter.instance.VARIABLES[args.arg2];
		set_view({arg1: args.arg1, arg2: viewID});
	}

	/**
		Sets the position of an undisplayed object on the screen.
		@param arg1 Indicates what object is being set.
		@param arg2 Position on the X axis
		@param arg3 Position on the Y axis
	**/
	public static function position(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.x = args.arg2;
		object.y = args.arg3;
	}

	/**
		Sets the position of an undisplayed object on the screen.
		@param arg1 Indicates what object is being set.
		@param arg2 Variable storing the X axis
		@param arg3 Variable storing the Y axis
	**/
	public static function position_v(args:Args) {
		var x:AGIByte = AGIInterpreter.instance.VARIABLES[args.arg2];
		var y:AGIByte = AGIInterpreter.instance.VARIABLES[args.arg3];
		position({arg1: args.arg1, arg2: x, arg3: y});
	}

	/**
		Copies the X and Y coordinates of a View Object n into specified variables.
		@param arg1 View Object ID of the object to get the coordinates from.
		@param arg2 Variable to store the X coordinate in.
		@param arg3 Variable to store the Y coordinate in.
	**/
	public static function get_posn(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		AGIInterpreter.instance.VARIABLES[args.arg2] = object.x;
		AGIInterpreter.instance.VARIABLES[args.arg3] = object.y;
	}

	// TODO: Implement Object Control commands
}
