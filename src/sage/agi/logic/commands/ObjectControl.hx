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
		object.viewFlags |= ViewFlags.ANIMATE;
		// TODO: Do we need to set other flags too??
	}

	/**
		Removes all ViewObjects from the list of animatable objects.
	**/
	public static function unanimate_all() {
		for (key => object in AGIInterpreter.instance.OBJECTS.keyValueIterator())
			object.viewFlags &= ~ANIMATE;
	}

	/**
		View Object n is associated with View resource number m.
		@param arg1 View Object ID
		@param arg2 View Resource Number
	**/
	public static function set_view(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.view = args.arg2;
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

	/**
		Sets the current View Loop to render.
		@param arg1 ID of the View Objec to set.
		@param arg2 Number of the loop to select
	**/
	public static function set_loop(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.loop = args.arg2.toInt();
	}

	/**
		Sets the current View Loop to render.
		@param arg1 ID of the View Objec to set.
		@param arg2 ID of the variable containing the number of the loop to select
	**/
	public static function set_loop_v(args:Args) {
		var loop:AGIByte = AGIInterpreter.instance.VARIABLES[args.arg2];
		set_loop({arg1: args.arg1, arg2: args.arg2});
	}

	/**
		Turns off automatic loop selection on a View Object.
		@param arg1 View Object ID
	**/
	public static function fix_loop(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags |= LOOP_FIXED;
	}

	/**
		Enables automatic loop selection on a View Object according to a direction table.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic
		@param arg1
	 */
	public static function release_loop(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags &= ~LOOP_FIXED;
	}

	/**
		Set the current cel to render from the current loop.
		@param arg1 View Object
		@param arg2 ID of the cel to select
	**/
	public static function set_cel(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.currentCell = args.arg2.toInt();
	}

	/**
		Set the current cel to render from the current loop.
		@param arg1 View Object
		@param arg2 Variable containing the ID of the cel to select
	**/
	public static function set_cel_v(args:Args) {
		var celID:AGIByte = AGIInterpreter.instance.VARIABLES[args.arg1];
		set_cel({arg1: args.arg1, arg2: celID});
	}

	/**
		Stores the ID of the last cel of the current loop into a variable.
		@param arg1 ID of the View Object to get the last cel from.
		@param arg2 Variable to store the last cel ID in.
	**/
	public static function last_cel(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		var view:AGIView = AGIInterpreter.instance.VIEWS.get(object.view);
		AGIInterpreter.instance.VARIABLES[args.arg2] = view.getViewLoops()[object.loop].loopCells.length - 1;
	}

	/**
		Sets the ID of the current cel to a variable.
		@param arg1 View Object to get the current cel from
		@param arg2 Variable to set the current cel to.
	**/
	public static function current_cel(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		AGIInterpreter.instance.VARIABLES[args.arg2] = object.currentCell;
	}

	/**
		Sets the ID of the current loop to a variable.
		@param arg1 ID of the View Object to get the current loop ID
		@param arg2 Variable ID  to set the current loop ID
	**/
	public static function current_loop(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		AGIInterpreter.instance.VARIABLES[args.arg2] = object.loop;
	}

	/**
		Sets the ID of the current view used by the view object to a variable.
		@param arg1 View Object ID
		@param arg2 Variable to set the current view resource number to
	**/
	public static function current_view(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		AGIInterpreter.instance.VARIABLES[args.arg2] = object.view;
	}

	/**
		Sets the number of loops of the current loop of a view object to a variable.
		@param arg1 ID of the View Object
		@param arg2 Variable to set the number of loops to
	**/
	public static function number_of_loops(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		var view:AGIView = AGIInterpreter.instance.VIEWS.get(object.view);
		AGIInterpreter.instance.VARIABLES[args.arg2] = view.getViewLoops().length;
	}

	/**
		Sets the priority band of the View Object. The View Object flag is set to FIXED_PRIORITY.
		@param arg1 View Object ID
		@param arg2 Priority number
	**/
	public static function set_priority(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags |= FIXED_PRIORITY;
		object.priority = args.arg2;
	}

	/**
		Sets the priority band of the View Object. The View Object flag is set to FIXED_PRIORITY.
		@param arg1 View Object ID
		@param arg2 Variable where the priority number is stored
	**/
	public static function set_priority_v(args:Args) {
		var priority:AGIByte = AGIInterpreter.instance.VARIABLES[args.arg2];
		set_priority({arg1: args.arg1, arg2: priority});
	}

	/**
		Releases priority on the View Object so that the priority is no longer fixed. This will allow the View Object to scale the closer it gets to the viewer.
		@param arg1 View Object to release the priority on
	**/
	public static function release_priority(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		object.viewFlags &= ~FIXED_PRIORITY;
		object.priority = null; // TODO: Should this be set to 0 rather??
	}

	/**
	    Gets the priority from the View Object and stores it in a variable.
		@param arg1 View Object to get the priority from
		@param arg2 Variable to store the priority
	**/
	public static function get_priority(args:Args) {
		var object:ViewObject = AGIInterpreter.instance.OBJECTS.get(args.arg1);
		AGIInterpreter.instance.VARIABLES[args.arg2] = object.priority;
	}

	// TODO: Implement Object Control commands
}
