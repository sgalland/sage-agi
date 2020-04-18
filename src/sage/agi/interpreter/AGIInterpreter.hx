package sage.agi.interpreter;

import sage.agi.types.AGIByte;
import sage.agi.resources.AGIView;
import haxe.ds.Vector;

/**
	Represents the internals of the AGI Interpreter.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Internals
**/
class AGIInterpreter {
	private static var MAX_RESOURCES = 256;
	private static var MAX_STRINGS = 24;
	private static var views:Array<AGIView>;

	/**
		Defines an array of 256 8bit unsigned integer variables for use in the interpreter.
		The various variables have differing meanings in how they are used. See specification for more information.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Internals#Variable
	**/
	public static var variables:Vector<AGIByte> = new Vector<AGIByte>(MAX_RESOURCES);

	/**
		Defines an array of 256 boolean flags for use in the interpreter.
		The first 16 flags are reserved by the interpreter. See specification for more information.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Internals#Flag
	**/
	public static var flags:Vector<Bool> = new Vector<Bool>(MAX_RESOURCES);

	/**
		Defines an array of 24 40 character wide strings for use in the interpreter.

		Note that while some versions of the AGI Interpreter only supported 12 strings, some had the capacity to store 24. It is unknown if all 24 strings were used in those versions.

		See specification for more information.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Internals#String
	**/
	public static var strings:Vector<String> = new Vector<String>(MAX_STRINGS);

	public function new() {}
}
