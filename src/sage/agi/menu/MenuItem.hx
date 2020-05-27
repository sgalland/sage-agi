package sage.agi.menu;

import sage.agi.types.AGIByte;

class MenuItem {
	public var name:String;
	public var controlCode:AGIByte;
	public var enabled:Bool = true;

	public function new(name:String, controlCode:AGIByte) {
		this.name = name;
		this.controlCode = controlCode;
	}
}
// TODO: Document this class
