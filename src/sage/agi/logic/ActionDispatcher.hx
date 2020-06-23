package sage.agi.logic;

import sage.agi.logic.commands.PictureResourceManagement;
import sage.agi.logic.commands.Resource;
import sage.agi.logic.commands.ObjectMotionControl;
import sage.agi.logic.commands.ObjectControl;
import sage.agi.logic.commands.ProgramControl;
import sage.agi.logic.commands.ObjectControl;
import sage.agi.logic.commands.Text;
import haxe.ds.Map;
import sage.agi.logic.commands.Arithmetic;
import sage.agi.logic.commands.Flag;
import sage.agi.logic.commands.Initialization;
import sage.agi.logic.commands.Menu;
import sage.agi.logic.commands.Other;
import sage.agi.logic.commands.Subroutine;

/**
	Dispatches Actions based on the opcode.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Resources#Command_list_and_argument_types
**/
class ActionDispatcher {
	/**
		A map of all Actions that the interpreter can perform.
	**/
	public static var ACTIONS:Map<Int, Container> = [
        // 0x0 Return - this is handled during logic execution
		0x01 => new Container("increment", 1, [Variable], Arithmetic.increment),
		0x02 => new Container("decrement", 1, [Variable], Arithmetic.decrement),
		0x03 => new Container("assign", 2, [Variable,Number], Arithmetic.assign),
		0x04 => new Container("assignv", 2, [Variable,Variable], Arithmetic.assignv),
		0x05 => new Container("addn", 2, [Variable,Number], Arithmetic.addn),
		0x06 => new Container("addv", 2, [Variable,Variable], Arithmetic.addv),
		0x07 => new Container("subn", 2, [Variable,Number], Arithmetic.subn),
		0x08 => new Container("subv", 2, [Variable,Variable], Arithmetic.subv),
		0x09 => new Container("lindirectv", 2, [Variable,Variable], Arithmetic.lindirectv),
		0x0A => new Container("rindirect", 2, [Variable,Variable], Arithmetic.rindirect),
		0x0B => new Container("lindirectn", 2, [Variable,Number], Arithmetic.lindirectn),
		0x0C => new Container("set", 1, [Flag], Flag.set),
		0x0D => new Container("reset", 1, [Flag],Flag.reset),
		0x0E => new Container("toggle", 1, [Flag], Flag.toggle),
		0x0F => new Container("set.v", 1, [Variable], Flag.setv),
		0x10 => new Container("reset.v", 1, [Variable], Flag.resetv),
		0x11 => new Container("toggle.v", 1, [Variable], Flag.togglev),
		0x12 => new Container("new.room", 1, [Number], ProgramControl.new_room),
		0x13 => new Container("new.room.v", 1, [Variable], ProgramControl.new_room_v),
		0x14 => new Container("load.logic", 1, [Number], Resource.load_logic),
		0x15 => new Container("load.logic.v", 1, [Variable], Resource.load_logic_v),
		0x16 => new Container("call", 1, [Number], Subroutine.call),
		0x17 => new Container("call.v", 1, [Variable], Subroutine.call_v),
		0x18 => new Container("load.pic", 1, [Variable], Resource.load_pic),
		0x19 => new Container("draw.pic", 1, [Variable], PictureResourceManagement.draw_pic),
		0x1A => new Container("show.pic", 0, [], null),
		0x1B => new Container("discard.pic", 1, [Variable], null),
		0x1C => new Container("overlay.pic", 1, [Variable], null),
		0x1D => new Container("show.pri.screen", 0, [], null),
		0x1E => new Container("load.view", 1, [Number], Resource.load_view),
		0x1F => new Container("load.view.v", 1, [Variable], Resource.load_view_v),
		0x20 => new Container("discard.view", 1, [Number], null),
		0x21 => new Container("animate.obj", 1, [Object], ObjectControl.animate_obj),
		0x22 => new Container("unanimate.all", 0, [], null),
		0x23 => new Container("draw", 1, [Object], null),
		0x24 => new Container("erase", 1, [Object], null),
		0x25 => new Container("position", 3, [Object, Number, Number], null),
		0x26 => new Container("position.v", 3, [Object, Variable, Variable], ObjectControl.position_v),
		0x27 => new Container("get.posn", 3, [Object, Variable, Variable], null),
		0x28 => new Container("reposition", 3, [Object, Variable, Variable], null),
		0x29 => new Container("set.view", 2, [Object, Number], null),
		0x2A => new Container("set.view.v", 2, [Object, Variable], null),
		0x2B => new Container("set.loop", 2, [Object, Number], null),
		0x2C => new Container("set.loop.v", 2, [Object, Variable], null),
		0x2D => new Container("fix.loop", 1, [Object], null),
		0x2E => new Container("release.loop", 1, [Object], null),
		0x2F => new Container("set.cel", 2, [Object, Number], null),
		0x30 => new Container("set.cel.v", 2, [Object, Variable], null),
		0x31 => new Container("last.cel", 2, [Object, Variable], null),
		0x32 => new Container("current.cel", 2, [Object, Variable], null),
		0x33 => new Container("current.loop", 2, [Object, Variable], null),
		0x34 => new Container("current.view	", 2, [Object,Variable], null),
		0x35 => new Container("number.of.loops", 2, [Object, Variable], null),
		0x36 => new Container("set.priority", 2, [Object, Number], null),
		0x37 => new Container("set.priority.v", 2, [Object, Variable], null),
		0x38 => new Container("release.priority", 1, [Object], null),
		0x39 => new Container("get.priority", 2, [Object, Variable], null),
		0x3A => new Container("stop.update", 1, [Object], null),
		0x3B => new Container("start.update", 1, [Object], null),
		0x3C => new Container("force.update", 1, [Object], null),
		0x3D => new Container("ignore.horizon", 1, [Object], null),
		0x3E => new Container("observe.horizon", 1, [Object], null),
		0x3F => new Container("set.horizon", 1, [Number], ObjectMotionControl.set_horizon),
		0x40 => new Container("object.on.water", 1, [Object], null),
		0x41 => new Container("object.on.land", 1, [Object], null),
		0x42 => new Container("object.on.anything", 1, [Object], null),
		0x43 => new Container("ignore.objs", 1, [Object], null),
		0x44 => new Container("observe.objs", 1, [Object], null),
		0x45 => new Container("distance", 3, [Object, Object, Variable], null),
		0x46 => new Container("stop.cycling", 1, [Object], null),
		0x47 => new Container("start.cycling", 1, [Object], null),
		0x48 => new Container("normal.cycle", 1, [Object], null),
		0x49 => new Container("end.of.loop", 2, [Object, Flag], null),
		0x4A => new Container("reverse.cycle", 1, [Object], null),
		0x4B => new Container("reverse.loop", 2, [Object, Flag], null),
		0x4C => new Container("cycle.time", 2, [Object, Variable], null),
		0x4D => new Container("stop.motion", 1, [Object], null),
		0x4E => new Container("start.motion", 1, [Object], null),
		0x4F => new Container("step.size", 1, [Object], null),
		0x50 => new Container("step.time", 2, [Object, Variable], null),
		0x51 => new Container("move.obj", 5, [Object, Number], null),
		0x52 => new Container("move.obj.v", 5, [Object, Variable], null),
		0x53 => new Container("follow.ego", 3, [Object, Number, Flag], null), // TODO: The last flag is a done flag and it might not be needed.
		0x54 => new Container("wander", 1, [Object], null),
		// ...
		0x61 => new Container("load.sound", 1, [Number], Resource.load_sound),
		// ...
		0x66 => new Container("print.v", 1, [Variable], null),
		// ...
		0x69 => new Container("clear.lines", 3, [Number, Number, Message], Text.clear_lines),
		// ...
		0x6C => new Container("set.cursor.char", 1, [Message], Text.set_cursor_char),
		0x6D => new Container("set.text.attribute", 2, [Number, Number], Text.set_text_attribute),
		// ...
		0x6F => new Container("configure.screen", 3, [Number, Number, Number], Other.configure_screen),
		// ...
		0x70 => new Container("status.line.on", 0, [], Text.status_line_on),
		0x71 => new Container("status.line.off", 0, [], Text.status_line_off),
		// ...
		0x72 => new Container("set.string", 2, [LogicArgumentType.String, Message], sage.agi.logic.commands.String.set_string),
		// ...
		0x77 => new Container("prevent.input", 0, [], Text.prevent_input),
		// ...
		0x79 => new Container("set.key", 3, [Number, Number, Control], Initialization.set_key), // TODO: the control is the event identifier...
		// ...
		0x84 => new Container("player.control", 0, [], ObjectMotionControl.player_control),
		// ...
		0x8E => new Container("script.size", 1, [Number], Initialization.script_size),
		0x8F => new Container("set.game.id", 1, [Message], Initialization.set_game_id),
		// ...
		0x90 => new Container("log", 1, [Message], Initialization.log),
		// ...
		0x95 => new Container("trace.on", 0, [], Initialization.trace_on),
		0x96 => new Container("trace.info", 3, [Number, Number, Number], Initialization.trace_info),
		// ...
		0x9C => new Container("set.menu", 1, [Message], Menu.set_menu),
		0x9D => new Container("set.menu.item", 2, [Message, Control], Menu.set_menu_item),
		0x9E => new Container("submit.menu", 0, [], Menu.submit_menu),
		0x9F => new Container("enable.item", 1, [Control], Menu.enable_item),
		0xA0 => new Container("disable.item", 1, [Control], Menu.disable_item),
		0xA1 => new Container("menu.input", 0, [], Menu.menu_input)
	]; // TODO: Fill out the rest of the Actions
}