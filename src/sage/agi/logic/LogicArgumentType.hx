package sage.agi.logic;

/**
	Enum indicating the type of argument used in Logic Actions and Tests.
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
}
