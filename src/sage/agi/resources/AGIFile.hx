package sage.agi.resources;

import haxe.io.Bytes;

class AGIFile {
	public function new() {}

	public var resourceID:Int; // 16bit int signed
	public var volNumber:Int; // unsigned 8bit
	public var fileSize:Int; // 16bit int signed
	public var data:Bytes; // unsigned 8bit array
}
