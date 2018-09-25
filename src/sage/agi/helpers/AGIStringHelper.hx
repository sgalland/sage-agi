package sage.agi.helpers;

import haxe.io.Bytes;

class AGIStringHelper {
	public static function getString(data:Bytes, pos:Int):String {
		var b:Int;
		var byteString:Array<Int> = new Array<Int>();
		var loopIterator = 0;

		do {
			b = data.get(pos + loopIterator++);
			byteString.push(b);
		} while (b != 0x00);

		var retString:String = "";

		byteString.map(function(v) {
			retString += String.fromCharCode(v);
		});
trace(retString);
		return retString;
	}
}
