package sage.agi.types;

using Std;

/**
	Represents an unsigned byte data type.
**/
@:notNull
abstract AGIByte(Int) {
	public inline function new(value:Int) {
		this = AGIByte.wrap(value);
	}

	@:from
	static public function fromInt(i:Int):AGIByte {
		return new AGIByte(i);
	}

	@:to
	public function toAGIByte():AGIByte {
		return new AGIByte(this);
	}

	@:op(A > B)
	public static inline function gt(a:AGIByte, b:Int):Bool {
		return a.toInt() > b;
	}

	@:op(A >= B)
	public static inline function gte(a:AGIByte, b:Int):Bool {
		return a.toInt() >= b;
	}

	@:op(A < B)
	public static inline function lt(a:AGIByte, b:Int):Bool
		return a.toInt() < b;

	@:op(A <= B)
	public static inline function lte(a:AGIByte, b:Int):Bool
		return a.toInt() <= b;

	@:op(A - B)
	public static inline function sub(a:AGIByte, b:Int):AGIByte
		return new AGIByte(a.toInt() - b);

	@:op(A + B)
	public static inline function add(a:AGIByte, b:Int):AGIByte
		return new AGIByte(a.toInt() + b);

	@:op(A > B)
	public static inline function gtAGIByte(a:AGIByte, b:AGIByte):Bool {
		return a.toInt() > b.toInt();
	}

	@:op(A >= B)
	public static inline function gteAGIByte(a:AGIByte, b:AGIByte):Bool {
		return a.toInt() >= b.toInt();
	}

	@:op(A < B)
	public static inline function ltAGIByte(a:AGIByte, b:AGIByte):Bool
		return a.toInt() < b.toInt();

	@:op(A <= B)
	public static inline function lteAGIByte(a:AGIByte, b:AGIByte):Bool
		return a.toInt() <= b.toInt();

	@:op(A - B)
	public static inline function subAGIByte(a:AGIByte, b:AGIByte):AGIByte
		return new AGIByte(a.toInt() - b.toInt());

	@:op(A + B)
	public static inline function addAGIByte(a:AGIByte, b:AGIByte):AGIByte
		return new AGIByte(a.toInt() + b.toInt());

	@:op(A * B)
	public static inline function mulAGIByte(a:AGIByte, b:AGIByte):AGIByte
		return new AGIByte(a.toInt() * b.toInt());

	@:op(A * B)
	public static inline function mulInt(a:AGIByte, b:Int):AGIByte
		return new AGIByte(a.toInt() * b);

	@:op(A / B)
	public static inline function divAGIByte(a:AGIByte, b:AGIByte):AGIByte
		return new AGIByte((a.toInt() / b.toInt()).int());

	@:op(A / B)
	public static inline function divInt(a:AGIByte, b:Int):AGIByte
		return new AGIByte((a.toInt() / b).int());

	inline function toInt():Int {
		return this;
	}

	/**
		AGI variables are a unsigned byte value between 0 and 255.
		If the value is outside of these ranges the value will wrap.
		@param m
	**/
	static function wrap(m:Int):Int {
		if (m > HIGH_UBYTE_RANGE)
			return m % HIGH_UBYTE_RANGE - 1;
		else if (m < LOW_UBYTE_RANGE)
			return wrap(m + HIGH_UBYTE_RANGE + 1);
		return m;
	}

	/**
		Defines the minimum value of an unsigned byte.
	**/
	static var LOW_UBYTE_RANGE:Int = 0;

	/**
		Defines the maximum value of an unsigned byte.
	**/
	static var HIGH_UBYTE_RANGE:Int = 255;
}
