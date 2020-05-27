package sage.agi.logic;

import sage.agi.interpreter.AGIInterpreter;
import sage.agi.resources.AGILogic;
import haxe.ds.GenericStack;
import haxe.ds.Vector;

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
	public static var currentLogic(default, set):AGILogic;

	private static function set_currentLogic(logic:AGILogic) {
		return currentLogic = logic;
	}

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
			trace(currentLogic.logicData.slice(currentLogic.logicIndex, currentLogic.logicIndex + 20));

			currentByte = currentLogic.tell; // Change this to a tellByte so we can check without incrementing the index

			#if debug
			var output:String = "";
			output += switch (currentByte) {
				case 0x00: "-->	return;\n}";
				case 0xFF: "";
				default: "";
			}
			trace(output);
			#end

			switch (currentByte) {
				case 0x00:
					running = false;
				case 0xFF:
					processIf();
				default:
					processAction();
			}
		} while (currentLogic.logicIndex < currentLogic.logicData.length && running);

		// TODO: Pop the callstack
	}

	static function processIf() {
		var currentByte:UInt = currentLogic.nextByte;
		var notCondition:Bool = false;
		var orCondition:Bool = false;
		var logicOperator:Bool = true;

		#if debug
		var output:String = "if ( ";
		#end

		do {
			currentByte = currentLogic.nextByte;

			switch (currentByte) {
				case 0xFD:
					notCondition = true;
				case 0xFC:
					orCondition = true;
				case 0xFF:
					{
						// Skip the body of the function if the result is false
						var functionSize = currentLogic.nextSingle;
						if (!logicOperator)
							currentLogic.logicIndex += functionSize;
						break;
					}
				default:
					{
						var condition:Container = TestDispatcher.TESTS.get(currentByte);
						if (condition != null) {
							var args:Array<Int> = getArguments(condition.argCount);

							#if debug
							output += condition.agiFunctionName + "(";

							for (i in 0...condition.argCount) {
								var prefix:String = "";
								if (condition.argTypes[i] == Variable)
									prefix = "v";
								else if (condition.argTypes[i] == Flag)
									prefix = "f";
								else if (condition.argTypes[i] == Number)
									prefix = "";
								output += (notCondition ? "not(" : "") + prefix + args[i];

								if (i != condition.argCount - 1)
									output += ", ";

								if (i != condition.argCount - 1) {
									if (orCondition)
										output += " || ";
									else if (condition.argCount > 1)
										output += " && ";
								}
							}

							output += (notCondition ? ")" : "") + ") ";
							#end

							var arg1:Int = condition.argCount >= 1 ? args[0] : 0;
							var arg2:Int = condition.argCount >= 2 ? args[1] : 0;
							var arg3:Int = condition.argCount >= 3 ? args[2] : 0;
							var arg4:Int = condition.argCount >= 4 ? args[3] : 0;
							var arg5:Int = condition.argCount >= 5 ? args[4] : 0;

							if (orCondition)
								logicOperator = logicOperator || condition.callback(arg1, arg2, arg3, arg4, arg5);
							else
								logicOperator = logicOperator && condition.callback(arg1, arg2, arg3, arg4, arg5);

							if (notCondition)
								logicOperator = !logicOperator;
						}
					}
			}
		} while (currentByte != 0xFF);

		#if debug
		output += ")";
		trace(output);
		#end
	}

	static function processAction() {
		var container:Container = ActionDispatcher.ACTIONS.get(currentLogic.nextByte);
		if (container != null) {
			var args = getArguments(container.argCount);

			#if debug
			switch (container.argCount) {
				case 1:
					trace("-->	" + container.agiFunctionName + "(" + args[0] + ")");
				case 2:
					trace("-->	" + container.agiFunctionName + "(" + args[0] + "," + args[1] + ")");
				case 3:
					trace("-->	" + container.agiFunctionName + "(" + args[0] + "," + args[1] + "," + args[2] + ")");
				case 4:
					trace("-->	" + container.agiFunctionName + "(" + args[0] + "," + args[1] + "," + args[2] + "," + args[3] + ")");
				case 5:
					trace("-->	" + container.agiFunctionName + "(" + args[0] + "," + args[1] + "," + args[2] + "," + args[3] + "," + args[4] + ")");
				case 6:
					trace("-->	" + container.agiFunctionName + "(" + args[0] + "," + args[1] + "," + args[2] + "," + args[3] + "," + args[4] + "," + args[5]
						+ ")");
				case 7:
					trace("-->	" + container.agiFunctionName + "(" + args[0] + "," + args[1] + "," + args[2] + "," + args[3] + "," + args[4] + "," + args[5]
						+ "," + args[6] + ")");
			}
			#end

			// Actions can take up to 7 parameters. Load the arguments and pass them to the bind call.
			// It will send only the ones it needs.
			var arg1:Int = container.argCount >= 1 ? args[0] : 0;
			var arg2:Int = container.argCount >= 2 ? args[1] : 0;
			var arg3:Int = container.argCount >= 3 ? args[2] : 0;
			var arg4:Int = container.argCount >= 4 ? args[3] : 0;
			var arg5:Int = container.argCount >= 5 ? args[4] : 0;
			var arg6:Int = container.argCount >= 6 ? args[5] : 0;
			var arg7:Int = container.argCount == 7 ? args[6] : 0;

			container.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
		}
	}

	static function getArguments(argCount:Int) {
		var arguments:Array<UInt> = new Array<UInt>();

		for (i in 0...argCount) {
			arguments[i] = currentLogic.logicData[currentLogic.logicIndex + i];
		}

		currentLogic.logicIndex += argCount;
		return arguments;
	}
}
