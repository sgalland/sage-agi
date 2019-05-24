package sage.agi.resources;

/**
	AGIFile represents the raw contents of bits from a VOL.* file.
	The raw bits are used to represent an AGI Resource (View, Pic, Sound, Logic).
**/
class AGIFile {
	public function new() {
		data = new Array<Int>();
	}

	/**
		The Resource ID of the file.
	**/
	public var resourceID:Int;

	/**
		The VOL file that the AGIFile was read from.
	**/
	public var volNumber:Int;

	/**
		Length of bytes in the AGIFile.
	**/
	public var fileSize:Int;

	/**
		Raw bytes in the AGIFile.
	**/
	public var data:Array<Int>;
}
