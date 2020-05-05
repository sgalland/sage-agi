package sage.agi.logic;

import sage.agi.interpreter.AGIInterpreter;
import sage.agi.resources.AGILogic;
import haxe.ds.GenericStack;

/**
	Executes logic files.
**/
class LogicProcessor {
	/**
		Represents the call stack of AGI Logic scripts in the order they are loaded.
	**/
	static var callStack:GenericStack<AGILogic> = new GenericStack<AGILogic>();

	/**
		The current logic file being executed.
	**/
	static var currentLogic:AGILogic;

	/**
		Execute a logic resource.
		@param resourceID ID of the resource to be executd.
	**/
	public static function execute(resourceID:UInt) {
		currentLogic = AGIInterpreter.instance.LOGICS.get(resourceID);
		currentLogic.loaded = true;
		callStack.add(currentLogic);
		var running:Bool = true;
		var currentByte:Int = 0;

		do {
			currentByte = currentLogic.nextByte;

			#if debug
			var output:String = ">>> ";
			output += switch (currentByte) {
				case 0x00: "return";
				case 0xFF: "if ";
				default: "command";
			}
			trace(output);
			#end

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
						if (condition != null) {
							var args:Array<Int> = getArguments(condition.argCount);

							#if debug
							var argTypes:Array<String> = new Array<String>();

							var output:String = ">>>    if (" + condition.agiFunctionName;

							for (i in 0...condition.argCount) {
								output += argTypes[i] + args[i];

								// handle "not" and "and" cases
								if (i != condition.argCount - 1) {
									if (orCondition)
										output += " || ";
								}
							}

							// condition.argTypes.map(function(v:LogicArgumentType) {
							// 	return switch (v) {
							// 		case Flag: "f";
							// 		case Variable: "v";
							// 		default: "";
							// 	}
							// });
							// Get the arguments and bind them to the LogicArgumentType
							trace(output);
							#end
						}
					}
			}
		} while (currentByte != 0xFF);
	}

	static function processAction(currentByte:UInt) {}

	static function getArguments(argCount:Int) {
		var arguments:Array<UInt> = new Array<UInt>();

		for (i in 0...argCount) {
			arguments[i] = currentLogic.logicData[currentLogic.logicIndex + i + 1];
		}

		return arguments;
	}
}
