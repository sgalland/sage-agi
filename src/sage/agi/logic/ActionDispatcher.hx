package sage.agi.logic;

import haxe.ds.Map;
import sage.agi.logic.commands.Arithmetic;
import sage.agi.logic.commands.Flag;
import sage.agi.logic.commands.Initialization;
import sage.agi.logic.commands.Menu;
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
		0x01 => new Container("increment", 1, [Variable], Arithmetic.increment.bind(_)),
		0x02 => new Container("decrement", 1, [Variable], Arithmetic.decrement.bind(_)),
		0x03 => new Container("assign", 2, [Variable,Number], Arithmetic.assign.bind(_, _)),
		0x04 => new Container("assignv", 2, [Variable,Variable], Arithmetic.assignv.bind(_, _)),
		0x05 => new Container("addn", 2, [Variable,Number], Arithmetic.addn.bind(_, _)),
		0x06 => new Container("addv", 2, [Variable,Variable], Arithmetic.addv.bind(_, _)),
		0x07 => new Container("subn", 2, [Variable,Number], Arithmetic.subn.bind(_, _)),
		0x08 => new Container("subv", 2, [Variable,Variable], Arithmetic.subv.bind(_, _)),
		0x09 => new Container("lindirectv", 2, [Variable,Variable], Arithmetic.lindirectv.bind(_, _)),
		0x0A => new Container("rindirect", 2, [Variable,Variable], Arithmetic.rindirect.bind(_, _)),
		0x0B => new Container("lindirectn", 2, [Variable,Number], Arithmetic.lindirectn.bind(_, _)),
		0x0C => new Container("set", 1, [Flag], Flag.set.bind(_)),
		0x0D => new Container("reset", 1, [Flag],Flag.reset.bind(_)),
		0x0E => new Container("toggle", 1, [Flag], Flag.toggle.bind(_)),
		0x0F => new Container("set.v", 1, [Variable], Flag.setv.bind(_)),
		// ...
		0x16 => new Container("call", 1, [Number], Subroutine.call.bind(_)),
		// ...
		0x66 => new Container("print.v", 1, [Variable], null), // TODO: Implement me!
		// ...
		0x8E => new Container("script.size", 1, [Number], Initialization.script_size.bind(_)),
		// ...
		0x9C => new Container("set.menu", 1, [Message], Menu.set_menu.bind(_)),
		0x9D => new Container("set.menu", 2, [Message, Control], Menu.set_menu_item.bind(_, _)),
		0x9E => new Container("submit.menu", 0, [], Menu.submit_menu),
		0x9F => new Container("enable.item", 1, [Control], Menu.enable_item),
		0xA0 => new Container("disable.item", 1, [Control], Menu.disable_item),
		0xA1 => new Container("menu.input", 0, [], Menu.menu_input)
	]; // TODO: Fill out the rest of the Actions
}