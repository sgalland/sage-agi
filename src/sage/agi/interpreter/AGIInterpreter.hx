package sage.agi.interpreter;

import sage.agi.logic.commands.Resource;
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
import sage.agi.resources.AGIPicture;
import sage.agi.AGIResourceType;
import sage.agi.logic.EventType;
import sage.agi.logic.LogicProcessor;
import sage.agi.menu.Menu;
import sage.agi.resources.AGIView.ViewObject;
import sage.agi.objects.ObjectBlock;

/**
	Represents the internals of the AGI Interpreter.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Internals
**/
class AGIInterpreter {
	/**
		The maximum number of resources allowed per resource type.
	**/
	public static inline final MAX_RESOURCES:Int = 255;

	/**
		AGI allowed in most interpreters 12 strings, but in some 24 strings. It is unknown if 24 were ever actually used.
	**/
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
		A map of <Int, AGIPicture> that represents all the loaded Picture files keyed by resource id.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Pic
	**/
	public var PICTURES:IntMap<AGIPicture> = new IntMap<AGIPicture>();

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
	public var DEBUGGER_SETTINGS:DebuggerSettings = {};

	/**
		Indicate what the current text attribute settings are.
	**/
	public var TEXT_ATTRIBUTE:TextAttribute;

	/**
		Settings that indicate the location of screen items (status bar, play area, input line).
	**/
	public var SCREEN:ScreenSettings = new ScreenSettings(0, 0, 0);

	/**
		Indicates if a player is able to type input via the keyboard.
	**/
	public var ALLOW_INPUT:Bool = true;

	/**
		View objects that can be animated.
	**/
	public var OBJECTS:IntMap<ViewObject> = new IntMap<ViewObject>();

	/**
		Defines a region that view objects cannot cross unless they are ignoring blocks.
	**/
	public var OBJECT_BLOCK:ObjectBlock = {};

	/**
		Indicates if the player is allowed to control the Ego.
	**/
	public var ALLOW_PLAYER_CONTROL:Bool;

	/**
		Current Picture to render.
	**/
	public var CURRENT_PIC:AGIPicture;

	/**
		Indicates if the UI should be updated due to a score or menu change.
	**/
	public var UPDATE_STATUS:Bool = false;

	/**
		Indicates if the new room command was issued.
	**/
	public var NEW_ROOM:Bool = false;

	/**
		Represent the keyboard buffer. Should this be a haxe stringbuf?
	**/
	public var KEYBOARD_BUFFER:Array<String> = new Array<String>();

	/**
		Singleton instance of the AGIInterpreter class.
	**/
	public static var instance:AGIInterpreter = new AGIInterpreter();

	public var processor:LogicProcessor = new LogicProcessor();

	function new() {}

	/**
		Initializes the interpreter for first run.
	**/
	public function initialize() {
		for (i in 0...MAX_RESOURCES) {
			AGIInterpreter.instance.OBJECTS.set(i, {});
		}

		Resource.load_logic({arg1: 0});
	}

	/**
		Executes the interpreters main logic loop.
		@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Internals#Interpreter_work_cycle
	**/
	public function run() {
		// Interpreter loop steps
		// 1. Time delay - this is a function of the host graphics API.
		// 2. Clear keyboard buffer - this is a function of the host graphics API since it usually handles events that we will need to trigger.
		// 3. Reset variables
		FLAGS.set(2, false); // Reset player entered a command
		FLAGS.set(4, false); // Reset the said command
		// 4. Poll the keyboard and the joystick - this is a function of the host API's event system. We might need to hook into it.

		NEW_ROOM = false; // TODO: Not sure if we should do this or not, but it seems appropriate.
		processor.execute(0);

		// 6. Reset dir of ego
		// if score v3 or flag 9 have changed their values reset variables
		if (/*VARIABLES.get(3) || FLAGS.get(9)*/ UPDATE_STATUS) {
			// TODO: What updates v3 and f9????? We need to set UPDATE_STATUS there
			// Update the status and score
			// VAR(3) -- to what??
			// What this means is update the status and the score on the UI
		}

		VARIABLES.set(5, 0); // Code of the border touched by v4
		VARIABLES.set(4, 0); // Object that touched the border
		FLAGS.set(5, false); // Reset room script ran for first time.
		FLAGS.set(6, false); // Reset restart game has executed.
		FLAGS.set(12, false); // Reset restore game has executed

		// Updated objects
		if (NEW_ROOM) { // test if the new.room command has been issued;
			// is this the same crap as the new room command??????
			// If so then we might not need this code block.
			// stop.update
			// unanimate.all
			// release all logics except 0
			// player.control
			// unblock
			// set.horizon(36) -- the default horizon value
			// var(1) = var(0)
		}
	}
}
