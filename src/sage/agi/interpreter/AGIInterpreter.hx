package sage.agi.interpreter;

import sage.agi.screen.ScreenSettings;
import sage.agi.text.TextAttribute;
import sage.agi.logic.DebuggerSettings;
import haxe.ds.IntMap;
import haxe.ds.List;
import haxe.ds.Vector;
import sage.agi.resources.AGILogic;
import sage.agi.resources.AGIFileReader;
import sage.agi.types.AGIByte;
import sage.agi.resources.AGIView;
import sage.agi.EAGIFileName;
import sage.agi.logic.EventType;
import sage.agi.logic.LogicProcessor;
import sage.agi.menu.Menu;
import sage.agi.resources.AGIView.ViewObject;

/**
	Represents the internals of the AGI Interpreter.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Internals
**/
class AGIInterpreter {
	public static inline final MAX_RESOURCES:Int = 255;
	public static inline final MAX_STRINGS = 24;

	/**
		Defines an array of 256 8bit unsigned integer variables for use in the interpreter.
		The various variables have differing meanings in how they are used. See specification for more information.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Internals#Variable
	**/
	public var VARIABLES:Vector<AGIByte> = new Vector<AGIByte>(MAX_RESOURCES);

	/**
		Defines an array of 256 boolean flags for use in the interpreter.
		The first 16 flags are reserved by the interpreter. See specification for more information.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Internals#Flag
	**/
	public var FLAGS:Vector<Bool> = new Vector<Bool>(MAX_RESOURCES);

	/**
		Defines an array of 24 40 character wide strings for use in the interpreter.

		Note that while some versions of the AGI Interpreter only supported 12 strings, some had the capacity to store 24.
		It is unknown if all 24 strings were used in those versions.

		See specification for more information.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Internals#String
	**/
	public var STRINGS:Vector<String> = new Vector<String>(MAX_STRINGS);

	/**
		A map of <Int,AGILogic> that represents all the Logic files keyed by resource id.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Resources#Logic_resources
	**/
	public var LOGICS:IntMap<AGILogic> = new IntMap<AGILogic>();

	/**
		A map of <Int, AGIView> that represents all the View files keyed by resource id.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/View
	**/
	public var VIEWS:IntMap<AGIView> = new IntMap<AGIView>();

	/**
		AGI Interpreter menu linked list.
	**/
	public var MENU:List<Menu> = new List<Menu>();

	/**
		Indicates if the menu is to be drawn on the screen. Set by sage.agi.logic.command.Menu.menu_input
	**/
	public var MENU_VISIBLE:Bool = false;

	/**
		Array of all loaded events.
	**/
	// TODO: Are these all set_key events or other events too???
	public var EVENT_TYPES:Array<EventType> = new Array<EventType>();

	/**
		Reference to the string used to display the cursor. The cursor is set when the Text command set.cursor.char is called.
	**/
	public var CURSOR:String;

	/**
		The game id that identifies the game by an abbreviated code. The game id is set when the Initialization command set.game.id is called.
	**/
	public var GAME_ID:String;

	/**
		Information about the debugger setup. Set when Initialization command trace.info is called.
	**/
	public var DEBUGGER_SETTINGS:DebuggerSettings;

	/**
		Indicate what the current text attribute settings are.
	**/
	public var TEXT_ATTRIBUTE:TextAttribute;

	/**
		Settings that indicate the location of screen items (status bar, play area, input line).
	**/
	public var SCREEN:ScreenSettings;

	/**
		Indicates if a player is able to type input via the keyboard.
	**/
	public var ALLOW_INPUT:Bool = true;

	/**
		View objects that can be animated.
	**/
	public var OBJECTS:IntMap<ViewObject> = new IntMap<ViewObject>();

	/**
		Singleton instance of the AGIInterpreter class.
	**/
	public static var instance:AGIInterpreter = new AGIInterpreter();

	function new() {
		initializeObjects();
		loadResources(LOGIC);
		loadResources(VIEW);
	}

	function initializeObjects() {
		for (i in 0...AGIInterpreter.MAX_RESOURCES) {
			OBJECTS.set(i, new ViewObject());
		}
	}

	function loadResources(fileName:EAGIFileName) {
		var resources = new AGIFileReader();
		resources.loadDirectoryEntries(fileName);
		for (entry in resources.directoryEntries) {
			var file = resources.getFile(entry.resourceID);
			if (file != null) {
				switch (fileName) {
					case LOGIC:
						LOGICS.set(entry.resourceID, new AGILogic(file, entry.resourceID));
					case VIEW:
						VIEWS.set(entry.resourceID, new AGIView(file));
					default:
						throw "An invalid AGI FileType was added.";
				}
			}
		}
	}

	public function run() {
		// time delay;
		// clear the keyboard buffer;
		// poll the keyboard and the joystick;
		// analyses some of the reserved variables and flags (see block diagram);
		FLAGS.set(2, false);
		FLAGS.set(4, false);
		// for all controllable objects for which animate.obj, start.update and draw commands were issued, directions of motion are recalculated;
		// LOGIC resource 0 is executed, as well as any logics it calls -- which, in turn, can call other logics.
		// -- Depending on the state of variables and flags analyzed at step 4 the number of commands interpreted
		// -- at stage 4 commands varies from one iteration of the cycle to another depending,
		// -- for example, on a number of LOGIC resources to be called in the current situation;
		LogicProcessor.execute(0);
		// test if the new.room command has been issued;
	}
}
