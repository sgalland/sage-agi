package sage.agi.logic;

import haxe.ds.Map;
import sage.agi.logic.commands.Arithmetic;
import sage.agi.logic.commands.Flag;

/**
	Dispatches Actions based on the opcode.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Resources#Command_list_and_argument_types
**/
class ActionDispatcher {
	/**
		A map of all Actions that the interpreter can perform.
	**/
	public static var ACTIONS:Map<Int, Dynamic> = [
        // 0 Return - this is handled during logic execution
		1 => Arithmetic.increment.bind(_),
		2 => Arithmetic.decrement.bind(_),
		3 => Arithmetic.assign.bind(_, _),
		4 => Arithmetic.assignv.bind(_, _),
		5 => Arithmetic.addn.bind(_, _),
		6 => Arithmetic.addv.bind(_, _),
		7 => Arithmetic.subn.bind(_, _),
		8 => Arithmetic.subv.bind(_, _),
		9 => Arithmetic.lindirectv.bind(_, _),
		10 => Arithmetic.rindirect.bind(_, _),
		11 => Arithmetic.lindirectn.bind(_, _),
		12 => Flag.set.bind(_),
		13 => Flag.reset.bind(_),
		14 => Flag.toggle.bind(_),
		15 => Flag.setv.bind(_),
	]; // TODO: Fill out the rest of the Actions
}
