package sage.agi;

using haxe.EnumTools;

/**
	Enumeration detailing all the normal file types for an AGI game files.

	Note that VOL files are numbered and are not standardized since they differ per game.
**/
@:enum abstract EAGIFileName(Int) {
	var AGIDATA = 1;
	var LOGIC = 2;
	var VIEW = 3;
	var PICTURE = 4;
	var SOUND = 5;
	var WORDS = 6;
}
