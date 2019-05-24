package sage.core;

/**
	BitSet represents a list of bits within a value.
**/
abstract BitSet(Array<Int>) {
	@:arrayAccess
	public inline function get(index:Int):Int
		return this[index];

	@:arrayAccess
	public inline function arrayWrite(index:Int, value:Int):Int {
		this[index] = value;
		return value;
	}

	/**
		Constructor
		@param bitWidth Defines how many bits should be in the Array.
		@param val The value to be deconstructed into bits.
	**/
	public function new(bitWidth:Int, val:Int) {
		/**
			Temporary array of bits to be assigned as the BitSet
		**/
		var bits = new Array<Int>();

		for (i in 0...bitWidth) {
			/**
				Extracted bit from the value
			**/
			var bit = (val & (1 << i)) >> i;

			bits.push(bit);
		}

		this = bits;
	}

	/**
		Returns an integer from a slice of values in the BitSet.
		@param startPosition
		@param endPosition
		@return Int
	**/
	public function getRangeByte(startPosition:Int, endPosition:Int):Int {
		/**
			Return value
		**/
		var r:Int = 0;

		/**
			Index variable
		**/
		var idx:Int = 0;

		if (startPosition < 0 || startPosition > endPosition || endPosition < startPosition || endPosition > this.length)
			throw "getRangeByte must have a range within the bits you are attemping to return";

		for (i in startPosition...endPosition) {
			if (this[i] != 0) {
				r |= (1 << idx);
			}
			idx++;
		}

		return r;
	}
}
