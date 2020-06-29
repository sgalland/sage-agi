package sage.agi.objects;

/**
	Flags that indicate various animation properties of a View Object.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/View#View_table_entry
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/View#View_flags
**/
enum ViewFlags {
	/**
		Indicates that the object is ready to be animated.
	**/
	ANIMATE;

	/**
		Flags the View Object to not pass through blocks. See observe.blocks(), ignore.blocks(), block(), unblock() in ObjectMotionControl.
	**/
	OBSERVE_BLOCKS;

	/**
		Determine what this does
	**/
	FIXED_PRIORITY; // TODO: Determine what this flag does

	/**
		Indicates that the View Object will not cross into the horizon.
	**/
	OBSERVE_HORIZON;

	/**
		Indicates that the view object is updatable every interpreter cycle. If this flag is not set, the object will remain on the screen and do nothing.
	**/
	UPDATE;

	CYCLING;

	/**
		Indicates that the View Object is on water.
	**/
	VIEW_ON_WATER;

	/**
		Indicates that the View Object is on land.
	**/
	VIEW_ON_LAND;

	/**
		Set when observed.objs() is called. ignore.objs() removes this flag.
	**/
	OBSERVE_OBJECTS;

	/**
		Indicates that the loop on the View Object is fixed and cannot be changed automatically.
	**/
	LOOP_FIXED;
}

/**
	Represents the direction that the View Object is facing.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/View#View_table_entry
**/
@:enum abstract Direction(Int) from Int to Int {
	var STATIONARY = 0;
	var NORTH = 1;
	var NORTH_EAST = 2;
	var EAST = 3;
	var SOUTH_EAST = 4;
	var SOUTH = 5;
	var SOUTH_WEST = 6;
	var WEST = 7;
	var NORTH_WEST = 8;
}

/**
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/View#View_table_entry
**/
@:enum abstract Motion(Int) from Int to Int {
	var NORMAL = 0;
	var WANDER = 1;
	var FOLLOW = 2;
	var MOVE_OBJECT = 3;
}

/**
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/View#View_table_entry
**/
@:enum abstract Cycle(Int) from Int to Int {
	var NORMAL = 0;
	var END_OF_LOOP = 1;
	var REVERSE_LOOP = 2;
	var REVERSE_CYCLE = 3;
}
