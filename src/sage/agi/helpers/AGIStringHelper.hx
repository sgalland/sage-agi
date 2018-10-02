package sage.agi.helpers;

import haxe.io.Bytes;

/**
	Helper methods for working with ASCII strings found in the Sierra AGI files.
**/
class AGIStringHelper {
	/**
		Converts bytes found at a specific starting location to a string. Stops when a null character is found.
	**/
	public static function getString(data:Bytes, pos:Int):String {
		var b:Int;
		var loopIterator = 0;
		var retString:String = "";

		do {
			b = data.get(pos + loopIterator++);
			retString += String.fromCharCode(b);
		} while (b != 0x00);

		return retString;
	}
}
