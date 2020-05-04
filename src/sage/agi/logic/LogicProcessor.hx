package sage.agi.logic;

import sage.agi.interpreter.AGIInterpreter;
import sage.agi.resources.AGILogic;
import haxe.ds.GenericStack;

class LogicProcessor {
	/**
		Represents the call stack of AGI Logic scripts in the order they are loaded.
	**/
	static var callStack:GenericStack<AGILogic> = new GenericStack<AGILogic>();

	/**
		The current logic file being executed.
	**/
	static var currentLogic:AGILogic;

	public static function execute(resourceID:UInt) {
		currentLogic = AGIInterpreter.LOGIC.get(resourceID);
		callStack.add(currentLogic);
		var running:Bool = true;
		var currentByte:Int = 0;

		do {
			currentByte = currentLogic.nextByte;
			switch (currentByte) {
				case 0x00:
					running = false;
				case 0xFF:
					processIf();
				default:
					processAction(currentByte);
			}
		} while (currentLogic.logicIndex < currentLogic.logicData.length && running);
	}

	static function processIf() {
		var currentByte = 0xFF;
		var notCondition:Bool = false;
		var orCondition:Bool = false;

		do {
			currentByte = currentLogic.nextByte;

			switch (currentByte) {
				case 0xFD:
					notCondition = false; // is this supposed to be true??
				case 0xFC:
					orCondition = true;
				case 0xFF:
					break;
				default:
					{
						var condition:Container = TestDispatcher.TESTS.get(currentByte);
						if (condition != null) {}
					}
			}
		} while (currentByte != 0xFF);
	}

	static function processAction(currentByte:UInt) {}
}
