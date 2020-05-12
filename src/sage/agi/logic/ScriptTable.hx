package sage.agi.logic;

import haxe.ds.Vector;

/**
	Stores command codes used by the interpreter. Used by loading and restoring the game.
**/
class ScriptTable {
	var table:Vector<UInt>;

	/**
		Singleton instance of Script Table.
	**/
	public static var instance = new ScriptTable();

	/**
		Set the size of the script table.
		@param n size in bytes
	**/
	public function setSize(n:Int) {
		table = new Vector<UInt>(n);
	}

	private function new() {}
}
