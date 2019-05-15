package sage.agi.helpers;

/**
	Helper methods for working with ASCII strings found in the Sierra AGI files.
**/
class AGIStringHelper {
	/**
		Converts bytes found at a specific starting location to a string. Stops when a null character is found.
	**/
	public static function getString(data:Array<Int>, pos:Int):String {
		var b:Int;
		var loopIterator = 0;
		var retString:String = "";

		do {
			b = data[pos + loopIterator++];
			retString += String.fromCharCode(b);
		} while (b != 0x00);

		return retString;
	}
}
