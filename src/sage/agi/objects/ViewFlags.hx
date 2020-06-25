package sage.agi.objects;

/**
	Flags that indicate various animation properties of a View Object.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/View#View_table_entry
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/View#View_flags
**/
@:enum abstract ViewFlags(Int) from Int to Int {
	/**
		Animate is not a real view flag and might be ok to remove.
		Indicates that the object is ready to be animated.
	**/
	var ANIMATE = 0;

	/**
		Flags the View Object to not pass through blocks. See observe.blocks(), ignore.blocks(), block(), unblock() in ObjectMotionControl.
	**/
	var OBSERVE_BLOCKS = 1;

	/**
		Determine what this does
	**/
	var FIXED_PRIORITY = 2; // TODO: Determine what this flag does

	var OBSERVE_HORIZON = 3;

	/**
		Indicates that the view object is updatable every interpreter cycle. If this flag is not set, the object will remain on the screen and do nothing.
	**/
	var UPDATE = 4;

	var CYCLING = 5;

	/**
		Indicates that the View Object is on water.
	**/
	var VIEW_ON_WATER = 8;

	/**
		Indicates that the View Object is on land.
	**/
	var VIEW_ON_LAND = 9;

	/**
		Set when observed.objs() is called. ignore.objs() removes this flag.
	**/
	var OBSERVE_OBJECTS = 10;

	/**
		Indicates that the loop on the View Object is fixed and cannot be changed automatically.
	**/
	var LOOP_FIXED = 13;
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
