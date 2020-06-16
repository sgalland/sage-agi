package sage.agi.logic;

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
		// ...
		0x12 => new Container("new.room", 1, [Number], ProgramControl.new_room),
		// ...
		0x14 => new Container("load.logic", 1, [Number], Resource.load_logic),
		0x15 => new Container("load.logic.v", 1, [Variable], Resource.load_logic_v),
		// ...
		0x16 => new Container("call", 1, [Number], Subroutine.call),
		// ...
		0x18 => new Container("load.picture", 1, [Variable], Resource.load_pic),
		// ...
		0x21 => new Container("animate.obj", 1, [Object], ObjectControl.animate_obj),
		// ...		
		0x26 => new Container("position.v", 3, [Object, Variable, Variable], ObjectControl.position_v),
		// ...
		0x61 => new Container("load.sound", 1, [Number], Resource.load_sound),
		// ...
		0x66 => new Container("print.v", 1, [Variable], null), // TODO: Implement me!
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