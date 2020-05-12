package sage.agi.logic.commands;

import haxe.ds.Vector;

class Initialization {
	/**
		Sets the size of the script table in bytes.
		@param n Size of the script table to allocate.
	**/
	public static function script_size(n:UInt) {
		ScriptTable.instance.setSize(n);
	}
}
