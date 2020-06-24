package sage.agi.logic.commands;

import sage.agi.types.AGIByte;
import sage.agi.resources.AGIView;
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
		@param arg1 Number of the Resource ID
	**/
	public static function load_logic(args:Args) {
		var file:AGIFile = load_resource(AGIResourceType.LOGIC, args.arg1);
		AGIInterpreter.instance.LOGICS.set(args.arg1, new AGILogic(file));
	}

	/**
		Load a logic resource by variable n.
		@param arg1 Variable ID
	**/
	public static function load_logic_v(args:Args) {
		var resourceID:Int = AGIInterpreter.instance.VARIABLES[args.arg1];
		load_logic({arg1: resourceID});
	}

	/**
		Load a picture resource by variable n. Note that there is not a load.pic.v function in AGI for unknown reasons.
		@param arg1 Variable ID
	**/
	public static function load_pic(args:Args) {
		var resourceID:Int = AGIInterpreter.instance.VARIABLES[args.arg1];
		var file:AGIFile = load_resource(AGIResourceType.PICTURE, resourceID);
		AGIInterpreter.instance.PICTURES.set(resourceID, new AGIPicture(file));
	}

	/**
		Load a View by resource number.
		@param arg1 Number of the Resource ID
	**/
	public static function load_view(args:Args) {
		var file:AGIFile = load_resource(AGIResourceType.VIEW, args.arg1);
		AGIInterpreter.instance.VIEWS.set(args.arg1, new AGIView(file));
	}

	/**
		Load a View by resource number stored in a variable.
		@param arg1 Variable ID
	**/
	public static function load_view_v(args:Args) {
		var resourceID:Int = AGIInterpreter.instance.VARIABLES[args.arg1];
		load_view({arg1: resourceID});
	}

	/**
		Load sound resource by variable n.
		@param arg1 Variable ID
	**/
	public static function load_sound(args:Args) {
		// TODO: Complete sounds
		var file:AGIFile = load_resource(AGIResourceType.SOUND, args.arg1);
		// AGIInterpreter.instance.SOUNDS.set(args.arg1, new AGISound(file));
	}

	/**
		Discards a picture resource from memory.
		@param arg1 Variable of the picture to discard.
	**/
	public static function discard_pic(args:Args) {
		var resourceID:AGIByte = AGIInterpreter.instance.VARIABLES[args.arg1];
		AGIInterpreter.instance.PICTURES.set(resourceID, null);
	}

	/**
		Discards a view resource from memory.
		@param arg1 Resource id of the view to discard.
	**/
	public static function discard_view(args:Args) {
		AGIInterpreter.instance.VIEWS.set(args.arg1, null);
	}

	/**
		Discards a view resource from memory.
		@param arg1 Variable containing the resource id of the view to discard.
	**/
	public static function discard_view_v(args:Args) {
		var resourceID:AGIByte = AGIInterpreter.instance.VARIABLES[args.arg1];
		discard_view({arg1: resourceID});
	}

	static function load_resource(fileType:AGIResourceType, resourceID:UInt):AGIFile {
		var loader:AGIFileReader = new AGIFileReader();
		loader.loadDirectoryEntries(fileType);
		return loader.getFile(resourceID);
	}

	// TODO: Implement Resource loading/unloading commands
}
