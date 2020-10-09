package sage.agi;

import haxe.ds.IntMap;

enum Key {
	F1;
	F2;
	F3;
	F4;
	F5;
	F6;
	F7;
	F8;
	F9;
	F10;
	F11;
	F12;

	a;
}

enum KeyboardMapping {
	Mapping(key:Key, keyCode:Int, scanCode:Int);
}

class KBM extends IntMap<KeyboardMapping> {
	public function new() {
		super();
		this.set(65, Mapping(a, 65, 0x1E));

		this.set(112, Mapping(F1, 112, 0x3B));
		this.set(113, Mapping(F2, 113, 0x3C));
		this.set(114, Mapping(F3, 114, 0x3D));
		this.set(115, Mapping(F4, 115, 0x3E));
		this.set(116, Mapping(F5, 116, 0x3F));
		this.set(117, Mapping(F6, 117, 0x40));
		this.set(118, Mapping(F7, 118, 0x41));
		this.set(119, Mapping(F8, 119, 0x42));
		this.set(120, Mapping(F9, 120, 0x43));
		this.set(121, Mapping(F10, 121, 0x44));
		this.set(122, Mapping(F11, 122, 0x85));
		this.set(123, Mapping(F12, 123, 0x86));
	}
}

class AGIEvent {}

class AGIKeyboardEvent extends AGIEvent {
	public function new(charCode:Int) {
		this.charCode = charCode;
	}

	public var charCode:Int;
}
