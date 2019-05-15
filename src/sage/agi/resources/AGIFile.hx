package sage.agi.resources;

import haxe.io.Bytes;

class AGIFile {
	public function new() {
		data = new Array<Int>();
	}

	public var resourceID:Int; // 16bit int signed
	public var volNumber:Int; // unsigned 8bit
	public var fileSize:Int; // 16bit int signed
	public var data:Array<Int>; // Bytes; // unsigned 8bit array
}
