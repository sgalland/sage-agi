package sage.agi.screen;

import haxe.ds.Vector;

// TODO: Experimental!!!!

/**
	Hold info for rendering (backbuffer)
**/
class Renderer {
	public var videoBackBuffer:Vector<Int> = new Vector<Int>(320 * 160);

	public var priorityBackBuffer:Vector<Int> = new Vector<Int>(320 * 160);

	public function new() {}
}
