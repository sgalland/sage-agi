package sage.agi.logic.commands;

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
	public static function load_logic(n:UInt) {
		var file = load_resource(EAGIFileName.LOGIC, n);
		var logic = new AGILogic(file, n);
		AGIInterpreter.instance.LOGICS.set(n, logic);
	}

	/**
		Load a logic resource by variable n.
		@param n Variable ID
	**/
	public static function load_logic_v(n:UInt) {
		var resourceID = AGIInterpreter.instance.VARIABLES[n];
		load_logic(resourceID);
	}

	/**
		Load a picture resource by variable n. Note that there is not a load.pic.v function in AGI for unknown reasons.
		@param n Variable ID
	**/
	public static function load_pic(n:UInt) {
		var resourceID = AGIInterpreter.instance.VARIABLES[n];
		// what happens when we load invalid id's??
		var file = load_resource(EAGIFileName.PICTURE, resourceID);
		trace(file.resourceID);
		var pic = new AGIPicture(file);
		AGIInterpreter.instance.PICTURES.set(resourceID, pic);
	}

	/**
		Load sound resource by variable n.
		@param n Variable ID
	**/
	public static function load_sound(n) {
		// TODO: Implement sound
	}

	static function load_resource(fileType:EAGIFileName, resourceID:UInt):AGIFile {
		var loader:AGIFileReader = new AGIFileReader();
		loader.loadDirectoryEntries(fileType);
		return loader.getFile(resourceID);
	}

	// TODO: Implement Resource loading/unloading commands
}
