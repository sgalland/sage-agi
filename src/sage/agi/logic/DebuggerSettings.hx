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
		Top line to display the debugger
	**/
	public var topLine:UInt; // TODO: Not sure what this is exactly.

	/**
		Height of the debugger window.
	**/
	public var height:UInt;

	public function new() {}
}
