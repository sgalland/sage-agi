package sage.core;


class BitConverter {
	public static function toInt(value:Array<Int>, startIndex:Int) {
		var values = [value[startIndex], value[startIndex + 1]];
		return values[0] + (values[1] << 8);
	}
}
