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

	var currentLogic:AGILogic;

	/**
		Execute a logic resource.
		@param resourceID ID of the resource to be executd.
	**/
	public function execute(resourceID:UInt) {
		currentLogic = AGIInterpreter.instance.LOGICS.get(resourceID);
		var running:Bool = true;
		var currentByte:Int = 0;

		do {
			trace(currentLogic.logicData.slice(currentLogic.logicIndex, currentLogic.logicIndex + 20));

			currentByte = currentLogic.tell; // Check what byte is there but don't increment it.

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
		} while (currentLogic.logicIndex < currentLogic.logicData.length && running);
	}

	function processIf() {
		var currentByte:UInt = currentLogic.nextByte;
		var notCondition:Bool = false;
		var orCondition:Bool = false;
		logicOperator = true;

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
		currentLogic.nextByte; // throw away the 0xFE
		var functionSize = currentLogic.nextSingle;
		if (logicOperator) { // If we processed the if statement, skip the else statement
			currentLogic.logicIndex += functionSize;
		}
	}

	function processAction() {
		var container:Container = ActionDispatcher.ACTIONS.get(currentLogic.nextByte);
		if (container != null) {
			var args = getArguments(container.argCount);

			#if debug
			switch (container.argCount) {
				case 0:
					trace("-->	" + container.agiFunctionName + "()");
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

			// TODO: Remove this once it appears everything is implemented.
			if (container.callback == null) {
				trace('${container.agiFunctionName} is not defined.');
				return;
			}

			// TODO: Bring the arg assignment down here
			var args:Args = new Args();
			args.arg1 = arg1;
			args.arg2 = arg2;
			args.arg3 = arg3;
			args.arg4 = arg4;
			args.arg5 = arg5;
			args.arg6 = arg6;
			args.arg7 = arg7;
			args.logic = currentLogic;
			
			container.callback(args);
		}
	}

	function getArguments(argCount:Int):Array<UInt> {
		var arguments:Array<UInt> = new Array<UInt>();

		for (i in 0...argCount) {
			arguments[i] = currentLogic.logicData[currentLogic.logicIndex + i];
		}

		currentLogic.logicIndex += argCount;
		return arguments;
	}

	public function new() {}
}

class Args {
	public var arg1:AGIByte;
	public var arg2:AGIByte;
	public var arg3:AGIByte;
	public var arg4:AGIByte;
	public var arg5:AGIByte;
	public var arg6:AGIByte;
	public var arg7:AGIByte;
	public var logic:AGILogic;

	public function new() {}
}

// class ArgsExtensions {
// 	public static function composeArgs(arg1:Null<AGIByte>, arg2:Null<AGIByte>, arg3:Null<AGIByte>, arg4:Null<AGIByte>, arg5:Null<AGIByte>, arg6:Null<AGIByte>,
// 			arg7:Null<AGIByte>, logic:AGILogic):Args {
// 		return {
// 			arg1: arg1,
// 			arg2: arg2,
// 			arg3: arg3,
// 			arg4: arg4,
// 			arg5: arg5,
// 			arg6: arg6,
// 			arg7: arg7,
// 			logic: logic
// 		};
// 	}
// }
