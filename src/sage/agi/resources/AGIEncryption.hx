package sage.agi.resources;

import haxe.io.Bytes;

class AGIEncryption {
	private static inline var ENCRYPTION_STRING = "Avis Durgan";

	public static function decryptArray(source:Bytes, start:Int, end:Int) {
		var i = start;
		var stringPosition = 0;
		while (i < end) {
			source.set(i, source.get(i) ^ Std.parseInt(ENCRYPTION_STRING.charAt(stringPosition++ % ENCRYPTION_STRING.length)));
			i++;
		}
	}
}
