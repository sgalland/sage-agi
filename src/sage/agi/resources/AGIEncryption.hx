package sage.agi.resources;

import haxe.io.Bytes;
import haxe.io.BytesData;

/**
 Collection of methods used for working with string encrypted data.
 **/
class AGIEncryption {

	private static inline var ENCRYPTION_STRING = "Avis Durgan";
	/**
	 * Decrypts the data found in the source array.
	 * @param source Encrypted bytes
	 * @param start Position to start decryption.
	 * @param end Position to end decryption.
	 */
	public static function decryptArray(source:Bytes, start:Int, end:Int) {
		var i = start;
		var stringPosition = 0;
		var sourceData = source.getData();
		
		while (i < end) {	
			source.set(i, sourceData[i++] ^ ENCRYPTION_STRING.charCodeAt(stringPosition++ % ENCRYPTION_STRING.length));
		}
	}
}
