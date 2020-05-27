package sage.agi.logic;

/**
	Manages the debugger parameters.
**/
class DebuggerSettings {
	/**
		Resource ID of the logic file with trace commands.
	**/
	public var resourceID:UInt;

	/**
		First line to display the debugger
	**/
	public var firstLine:UInt; // TODO: Not sure what this is exactly.

	/**
		Height of the debugger window.
	**/
	public var height:UInt;

	public function new(resourceID:UInt, firstLine:UInt, height:UInt) {
		this.resourceID = resourceID;
		this.firstLine = firstLine;
		this.height = height;
	}
}
