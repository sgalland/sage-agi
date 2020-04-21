package sage.agi.logic;

import sage.agi.logic.commands.Test;
/**
	Dispatches Tests based on the opcode.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Resources#Command_list_and_argument_types
**/
class TestDispatcher {
    public static var TESTS:Map<Int, Dynamic> = [
        1 => Test.equaln.bind(_, _),
        2 => Test.equalv.bind(_, _),
        3 => Test.lessn.bind(_, _),
        4 => Test.lessv.bind(_, _),
        5 => Test.greatern.bind(_, _),
        6 => Test.greaterv.bind(_, _),
        7 => Test.isset.bind(_),
        8 => Test.issetv.bind(_),
    ]; // TODO: Fill out the rest of the Tests
}