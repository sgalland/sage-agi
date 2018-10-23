package sage.core;

import haxe.io.Bytes;

class BitConverter {
	public static function toInt(value:Bytes, startIndex:Int) {
		var values = [value.get(startIndex), value.get(startIndex + 1)];
		return values[0] + (values[1] << 8);
	}
}
