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
			var output:String = "";
			output += switch (currentByte) {
				case 0x00: "-->	ret\n}";
				case 0xFF: "";
				default: "--> 	command";
			}
			trace(output);
			#end

			trace(currentLogic.logicData.slice(0,20));

			switch (currentByte) {
				case 0x00:
					running = false;
				case 0xFF:
					processIf();
				default:
					var functionSize = currentLogic.nextSingle; // we are 1 byte too far in the array...
					trace(functionSize);
					processAction(currentByte);
			}
		} while (currentLogic.logicIndex < currentLogic.logicData.length && running);
	}

	static function processIf() {
		var currentByte = 0xFF;
		var notCondition:Bool = false;
		var orCondition:Bool = false;
		var logicOperator:Bool = false;

		do {
			currentByte = currentLogic.nextByte;

			switch (currentByte) {
				case 0xFD:
					notCondition = false; // TODO: is this supposed to be true??
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

							var output:String = "if (" + condition.agiFunctionName + "(";

							for (i in 0...condition.argCount) {
								var prefix:String = "";
								if (condition.argTypes[i] == Variable)
									prefix = "v";
								else if (condition.argTypes[i] == Flag)
									prefix = "f";
								else if (condition.argTypes[i] == Number)
									prefix = "";
								output += prefix + args[i];

								if (i != condition.argCount - 1)
									output += ", ";

								// handle "not" and "and" cases
								// if (i != condition.argCount - 1) {
								// 	if (orCondition)
								// 		output += " || ";
								// 	else
								// 		output += " && ";
								// }
							}

							output += ") ";

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

							if (orCondition)
								logicOperator = logicOperator || condition.callback(args);
							else
								logicOperator = logicOperator && condition.callback(args);

							if (notCondition)
								logicOperator = !logicOperator;
						}
					}
			}
		} while (currentByte != 0xFF);
	}

	static function processAction(opcode:UInt) {
		var container:Container = ActionDispatcher.ACTIONS.get(opcode);
		if (container != null) {
			#if debug
			trace("-->	" + container.agiFunctionName);
			#end

			var args = getArguments(container.argCount);
			container.callback(args);
		}
	}

	static function getArguments(argCount:Int) {
		var arguments:Array<UInt> = new Array<UInt>();

		trace("--> logicIndex: " + currentLogic.logicIndex);

		for (i in 0...argCount) {
			arguments[i] = currentLogic.logicData[currentLogic.logicIndex + i];
		}

		currentLogic.logicIndex += argCount;
		trace("--> logicIndex: " + currentLogic.logicIndex);
		return arguments;
	}
}
