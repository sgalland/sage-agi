package sage.agi.objects;

/**
	Defines a block that View Objects cannot enter unless they are ignoring blocks.
**/
typedef ObjectBlock = {
	/**
		Top left coordinate
	**/
	@:optional var x1:Int;

	/**
		Top coordinate
	**/
	@:optional var y1:Int;

	/**
		Bottom right coordinate
	**/
	@:optional var x2:Int;

	/**
		Bottom coordinate
	**/
	@:optional var y2:Int;
};
