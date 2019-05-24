package sage.core;

import haxe.io.BytesOutput;
import haxe.io.BytesBuffer;
import haxe.io.BytesData;

abstract BitSet(Array<Int>) {
	// private var bitWidth:Int;
	// private var bits:Array<Int>;
	@:arrayAccess
	public inline function get(index:Int)
		return this[index];

	@:arrayAccess
	public inline function arrayWrite(index:Int, value:Int):Int {
		this[index] = value;
		return value;
	}

	public function new(bitWidth:Int, val:Int) {
		var bits = new Array<Int>();
		for (i in 0...bitWidth) {
			var bit = (val & (1 << i)) >> i;
			bits.push(bit);
		}

		this = bits;
	}

	public function getRangeByte(startPosition:Int, endPosition:Int) {
		var r:Int = 0;
		var idx:Int = 0;

		if (startPosition < 0 || startPosition > endPosition || endPosition < startPosition || endPosition > /*bits.*/ this.length)
			throw "getRangeByte must have a range within the bits you are attemping to return";

		// for (i in 0...bits.length) {
		for (i in 0...this.length) {
			if (i > endPosition)
				break;

			// if (bits[i] != 0) {
			if (this[i] != 0) {
				r |= (1 << idx);
			}
			idx++;
		}

		return r;
	}
}
