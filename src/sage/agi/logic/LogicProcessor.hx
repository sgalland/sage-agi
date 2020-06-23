package sage.agi.logic;

import sage.agi.types.AGIByte;
import sage.agi.logic.commands.Resource;
import sage.agi.interpreter.AGIInterpreter;
import sage.agi.resources.AGILogic;
import haxe.ds.GenericStack;
import haxe.ds.Vector;

/**
	Executes logic files.
**/
class LogicProcessor {
	/**
		Current result of the if statement. This is reset everytime an if statement is processed.
	**/
	var logicOperator:Bool;

	/**
		The logic data being executed.
	**/
	var currentLogic:AGILogic;

	/**
		Index that indicates the current byte being operated on.
	**/
	var logicIndex:Int;

	/**
		Execute a logic resource.
		@param resourceID ID of the resource to be executd.
	**/
	public function execute(resourceID:UInt) {
		currentLogic = AGIInterpreter.instance.LOGICS.get(resourceID);
		var running:Bool = true;
		var currentByte:Int = 0;

		do {
			trace(currentLogic.logicData.slice(logicIndex, logicIndex + 20));

			currentByte = currentLogic.logicData[logicIndex]; // Check what byte is there but don't increment it.

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
				case 0x00: // Indicates a return() statement
					running = false; // perhaps replace with break?
				case 0xFF:
					processIf();
				case 0xFE:
					processElse();
				default:
					processAction();
			}
		} while (logicIndex < currentLogic.logicData.length && running);
	}

	function processIf() {
		var currentByte:UInt = currentLogic.logicData[logicIndex++];
		var notCondition:Bool = false;
		var orCondition:Bool = false;
		logicOperator = true;

		#if debug
		var output:String = "if ( ";
		#end

		do {
			currentByte = currentLogic.logicData[logicIndex++];

			switch (currentByte) {
				case 0xFD:
					notCondition = true;
				case 0xFC:
					orCondition = true;
				case 0xFF:
					{
						// Skip the body of the function if the result is false
						var functionSize:Int = nextSingle();
						if (!logicOperator)
							logicIndex += functionSize;
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

							if (condition.callback == null) {
								trace('${condition.agiFunctionName} is not defined. Defaulting to false.');
								logicOperator = false;
								return;
							}

							if (orCondition)
								logicOperator = logicOperator || condition.callback(arg1, arg2, arg3, arg4, arg5);
							else
								logicOperator = logicOperator && condition.callback(arg1, arg2, arg3, arg4, arg5);

							if (notCondition) {
								logicOperator = !logicOperator;
								notCondition = false;
							}
						}
					}
			}
		} while (currentByte != 0xFF);

		#if debug
		output += ") == " + logicOperator;
		trace(output);
		#end
	}

	function processElse() {
		logicIndex++; // move past 0xFE
		var functionSize:Int = nextSingle();
		if (logicOperator) { // If we processed the if statement, skip the else statement
			logicIndex += functionSize;
		}
	}

	function processAction() {
		var container:Container = ActionDispatcher.ACTIONS.get(currentLogic.logicData[logicIndex++]);
		if (container != null) {
			var functionArgs = getArguments(container.argCount);

			#if debug
			switch (container.argCount) {
				case 0:
					trace("-->	" + container.agiFunctionName + "()");
				case 1:
					trace("-->	" + container.agiFunctionName + "(" + functionArgs[0] + ")");
				case 2:
					trace("-->	" + container.agiFunctionName + "(" + functionArgs[0] + "," + functionArgs[1] + ")");
				case 3:
					trace("-->	" + container.agiFunctionName + "(" + functionArgs[0] + "," + functionArgs[1] + "," + functionArgs[2] + ")");
				case 4:
					trace("-->	" + container.agiFunctionName + "(" + functionArgs[0] + "," + functionArgs[1] + "," + functionArgs[2] + "," + functionArgs[3]
						+ ")");
				case 5:
					trace("-->	" + container.agiFunctionName + "(" + functionArgs[0] + "," + functionArgs[1] + "," + functionArgs[2] + "," + functionArgs[3]
						+ "," + functionArgs[4] + ")");
				case 6:
					trace("-->	" + container.agiFunctionName + "(" + functionArgs[0] + "," + functionArgs[1] + "," + functionArgs[2] + "," + functionArgs[3]
						+ "," + functionArgs[4] + "," + functionArgs[5] + ")");
				case 7:
					trace("-->	" + container.agiFunctionName + "(" + functionArgs[0] + "," + functionArgs[1] + "," + functionArgs[2] + "," + functionArgs[3]
						+ "," + functionArgs[4] + "," + functionArgs[5] + "," + functionArgs[6] + ")");
			}
			#end

			// Actions can take up to 7 parameters. Load the arguments and pass them to the bind call.
			// It will send only the ones it needs.
			var args:Args = {
				arg1: container.argCount >= 1 ? functionArgs[0] : 0,
				arg2: container.argCount >= 2 ? functionArgs[1] : 0,
				arg3: container.argCount >= 3 ? functionArgs[2] : 0,
				arg4: container.argCount >= 4 ? functionArgs[3] : 0,
				arg5: container.argCount >= 5 ? functionArgs[4] : 0,
				arg6: container.argCount >= 6 ? functionArgs[5] : 0,
				arg7: container.argCount == 7 ? functionArgs[6] : 0,
				logic: currentLogic
			};

			// TODO: Remove this once it appears everything is implemented.
			if (container.callback == null) {
				trace('${container.agiFunctionName} is not defined.');
				return;
			}

			container.callback(args);
		}
	}

	function getArguments(argCount:Int):Array<UInt> {
		var arguments:Array<UInt> = new Array<UInt>();

		for (i in 0...argCount) {
			arguments[i] = currentLogic.logicData[logicIndex + i];
		}

		logicIndex += argCount;
		return arguments;
	}

	public function new() {}

	function nextSingle():Int {
		var b1:Int = currentLogic.logicData[logicIndex++];
		var b2:Int = currentLogic.logicData[logicIndex++];
		return 256 * b2 + b1;
	}
}

typedef Args = {
	@:optional var arg1:AGIByte;
	@:optional var arg2:AGIByte;
	@:optional var arg3:AGIByte;
	@:optional var arg4:AGIByte;
	@:optional var arg5:AGIByte;
	@:optional var arg6:AGIByte;
	@:optional var arg7:AGIByte;
	@:optional var logic:AGILogic;
}
