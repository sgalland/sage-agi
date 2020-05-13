package sage.agi.menu;

import sage.agi.types.AGIByte;

class MenuItem {
	public var name:String;
	public var code:AGIByte;

	public function new(name:String, code:AGIByte) {
		this.name = name;
		this.code = code;
	}
}
// TODO: Document this class
