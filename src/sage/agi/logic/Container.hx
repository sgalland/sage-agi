package sage.agi.logic;

import sage.agi.resources.AGILogic;

// TODO: Document Container
class Container {
	public var agiFunctionName(default, default):String;
	public var argCount(default, default):Int;
	public var argTypes(default, default):Array<LogicArgumentType>;
	public var callback(default, default):Dynamic;

	public function new(agiFunctionName:String, argCount:Int, argTypes:Array<LogicArgumentType>, callback:Dynamic) {
		this.agiFunctionName = agiFunctionName;
		this.argCount = argCount;
		this.argTypes = argTypes;
		this.callback = callback;
	}
}
