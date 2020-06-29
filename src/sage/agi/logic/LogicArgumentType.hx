package sage.agi.logic;

// TODO: Document

/**
	Enum indicating the type of argument used in Logic Actions and Tests.
	@see https://wiki.scummvm.org/index.php/AGI/Specifications/Internals#AGI_data_types
**/
@:enum abstract LogicArgumentType(Int) {
	/**
		Represents a Variable argument.
	**/
	var Variable = 1;

	/**
		Represents a Number argument.
	**/
	var Number = 2;

	/**
		Represents a Flag argument.
	**/
	var Flag = 3;

	/**
		Represents a Logic Message number.
	**/
	var Message = 4;

	/**
		Represents a Control number.
	**/
	var Control = 5;

	/**
		Represents a String argument.
	**/
	var String = 6;

	/**
		Represents a game object.
	**/
	var Object = 7;

	var Item = 8;

	var Word = 9;
}
