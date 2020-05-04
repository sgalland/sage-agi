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
	public static var ACTIONS:Map<Int, Container> = [
        // 0 Return - this is handled during logic execution
		1 => new Container("increment", 1,[Variable], Arithmetic.increment.bind(_)),
		2 => new Container("decrement", 1,[Variable], Arithmetic.decrement.bind(_)),
		3 =>new Container("assign", 2,[Variable,Number], Arithmetic.assign.bind(_, _)),
		4 =>new Container("assignv", 2,[Variable,Variable], Arithmetic.assignv.bind(_, _)),
		5 =>new Container("addn", 2,[Variable,Number], Arithmetic.addn.bind(_, _)),
		6 =>new Container("addv", 2,[Variable,Variable], Arithmetic.addv.bind(_, _)),
		7 =>new Container("subn", 2,[Variable,Number], Arithmetic.subn.bind(_, _)),
		8 =>new Container("subv", 2,[Variable,Variable], Arithmetic.subv.bind(_, _)),
		9 =>new Container("lindirectv", 2,[Variable,Variable], Arithmetic.lindirectv.bind(_, _)),
		10 =>new Container("rindirect", 2,[Variable,Variable], Arithmetic.rindirect.bind(_, _)),
		11 =>new Container("lindirectn", 2,[Variable,Number], Arithmetic.lindirectn.bind(_, _)),
		12 =>new Container("set", 1,[Flag], Flag.set.bind(_)),
		13 =>new Container("reset", 1, [Flag],Flag.reset.bind(_)),
		14 =>new Container("toggle", 1,[Flag], Flag.toggle.bind(_)),
		15 =>new Container("set.v", 1,[Variable], Flag.setv.bind(_)),
	]; // TODO: Fill out the rest of the Actions
}
