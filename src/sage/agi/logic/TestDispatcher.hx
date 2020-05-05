package sage.agi.logic;

import sage.agi.logic.commands.Test;

/**
	Dispatches Tests based on the opcode.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Resources#Command_list_and_argument_types
**/
class TestDispatcher {
	/**
		Defined tests for use when processing if statements.
	**/
	public static var TESTS:Map<Int, Container> = [
		0x01 => new Container("equaln", 2, [Variable, Number], Test.equaln.bind(_, _)),
		0x02 => new Container("equalv", 2, [Variable, Variable], Test.equalv.bind(_, _)),
		0x03 => new Container("lessn", 2, [Variable, Number], Test.lessn.bind(_, _)),
		0x04 => new Container("lessv", 2, [Variable, Variable], Test.lessv.bind(_, _)),
		0x05 => new Container("greatern", 2, [Variable, Number], Test.greatern.bind(_, _)),
		0x06 => new Container("greaterv", 2, [Variable, Variable], Test.greaterv.bind(_, _)),
		0x07 => new Container("isset", 1, [Flag], Test.isset.bind(_)),
		0x08 => new Container("issetv", 1, [Variable], Test.issetv.bind(_)),
	]; // TODO: Fill out the rest of the Tests

}
