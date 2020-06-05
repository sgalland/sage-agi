package sage.agi.objects;

/**
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/View#View_table_entry
**/
@:enum abstract ViewFlags(Int) from Int to Int {
	var ANIMATE = 1;
}

/**
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
