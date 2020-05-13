package sage.core;

/**
	Set of methods for extending the default Haxe Math class.
**/
class MathExtender {
	/**
		Generates a random number between the minimum and maximum value.
		@param min Minimum random value.
		@param max Maximum random value.
		@return Int
	**/
	public static function random(min:Int, max:Int):Int {
		// C generates random numbers between 0 and RAND_MAX which is compiler defined
		// and can differ between implementations. RAND_MAX minimum possible value as per
		// the standard is 32767.
		// https://www.gnu.org/software/libc/manual/html_node/ISO-Random.html
		var genRandNum = Math.random() * MAX_C_RANDOM_VALUE;
		return Std.int((genRandNum % ((max - min) + 1)) + min);
	}

	inline static var MAX_C_RANDOM_VALUE:Int = 32767;
}
