package sage.agi.resources;

import haxe.io.Bytes;

class AGIEncryption {
	private static inline var ENCRYPTION_STRING = "Avis Durgan";

	public static function decryptArray(source:Bytes, start:Int, end:Int) {
		var i = start;
		var stringPosition = 0;
		var sourceData = source.getData();
		var newString:String = "";
		while (i < end) {
			// this logic needs rewritten
			//var decryptedString:Int = sourceData[i] ^Std.parseInt(ENCRYPTION_STRING.charCodeAt(stringPosition++ % ENCRYPTION_STRING.length));
			//i++;
			//trace(String.fromCharCode(decryptedString));
			
		}
	}
}
