package sage.agi.logic.commands;

import sage.agi.logic.LogicProcessor.Args;
import sage.agi.resources.AGIPicture;
import sage.agi.resources.AGIFile;
import sage.agi.resources.AGILogic;
import sage.agi.resources.AGIFileReader;
import sage.agi.interpreter.AGIInterpreter;

/**
	Implementation of commands to load and unload AGI Resources.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Commands_to_load_and_unload_resources
**/
class Resource {
	/**
		Load a logic resource by number n
		@param n Number of the Resource ID
	**/
	public static function load_logic(args:Args) {
		var file = load_resource(AGIResourceType.LOGIC, args.arg1);
		AGIInterpreter.instance.LOGICS.set(args.arg1, new AGILogic(file));
	}

	/**
		Load a logic resource by variable n.
		@param n Variable ID
	**/
	public static function load_logic_v(args:Args) {
		var resourceID = AGIInterpreter.instance.VARIABLES[args.arg1];
		load_logic({arg1: resourceID});
	}

	/**
		Load a picture resource by variable n. Note that there is not a load.pic.v function in AGI for unknown reasons.
		@param n Variable ID
	**/
	public static function load_pic(args:Args) {
		var resourceID = AGIInterpreter.instance.VARIABLES[args.arg1];
		var file = load_resource(AGIResourceType.PICTURE, resourceID);
		AGIInterpreter.instance.PICTURES.set(resourceID, new AGIPicture(file));
	}

	/**
		Load sound resource by variable n.
		@param n Variable ID
	**/
	public static function load_sound(args:Args) {
		// TODO: Implement sound
	}

	static function load_resource(fileType:AGIResourceType, resourceID:UInt):AGIFile {
		var loader:AGIFileReader = new AGIFileReader();
		loader.loadDirectoryEntries(fileType);
		return loader.getFile(resourceID);
	}

	// TODO: Implement Resource loading/unloading commands
}
