package sage.agi;

using haxe.EnumTools;

/**
	Enumeration detailing all the normal resource types and files for an AGI game files.
	Note that VOL files are numbered and are not standardized since they differ per game.
**/
@:enum abstract AGIResourceType(Int) {
	/**
		Represents the AGIDATA.OVL
	**/
	var AGIDATA = 1;

	/**
		Represents LOGICDIR
	**/
	var LOGIC = 2;

	/**
		Represents VIEWDIR
	**/
	var VIEW = 3;

	/**
		Represents PICDIR
	**/
	var PICTURE = 4;

	/**
		Represents SOUNDDIR
	**/
	var SOUND = 5;

	/**
		Represents WORDS.TOK
	**/
	var WORDS = 6;
}
