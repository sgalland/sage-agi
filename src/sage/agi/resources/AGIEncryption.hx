package sage.agi.resources;

/**
	Collection of methods used for working with string encrypted data.
**/
class AGIEncryption {
	static inline var ENCRYPTION_STRING:String = "Avis Durgan";

	/**
		Decrypts the data found in the source array.
		@param source Encrypted bytes
		 @param start Position to start decryption.
		 @param end Position to end decryption.
	**/
	public static function decryptArray(source:Array<Int>, start:Int, end:Int) {
		var i = start;
		var stringPosition = 0;

		while (i < end) {
			source[i] = source[i++] ^ ENCRYPTION_STRING.charCodeAt(stringPosition++ % ENCRYPTION_STRING.length);
		}
	}
}
