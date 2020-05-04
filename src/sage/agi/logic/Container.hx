package sage.agi.logic;

import sage.agi.resources.AGILogic;

// TODO: Document Container
class Container {
	public var agiFunctionName(null, null):String;
	public var argCount(null, null):Int;
	public var argTypes(default, default):Array<LogicArgumentType>;
	public var callback(null, null):Dynamic;

	public function new(agiFunctionName:String, argCount:Int, argTypes:Array<LogicArgumentType>, callback:Dynamic) {
		this.agiFunctionName = agiFunctionName;
		this.argCount = argCount;
		this.argTypes = argTypes;
		this.callback = callback;
	}
}
