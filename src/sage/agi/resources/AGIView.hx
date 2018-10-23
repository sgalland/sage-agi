package sage.agi.resources;

import haxe.ds.Vector;
import sage.agi.resources.AGIFile;
import sage.core.BitConverter;

class AGIView {
	private static inline var MAX_CEL:Int = 255;

	private var loopCount:Int;
	private var description:String;
	private var cellLocations:Vector<Vector<Int>>;
	private var loopLocations:Vector<Int>;
	private var celsInLoopCount:Vector<Int>;

	// std::vector<ViewLoop> viewLoops;
	private function initialize() {
		cellLocations = new Vector(MAX_CEL);
		for (i in 0...cellLocations.length)
			cellLocations[i] = new Vector(MAX_CEL);

		loopLocations = new Vector(MAX_CEL);
		celsInLoopCount = new Vector(MAX_CEL);
	}

	private function loadViewHeader(file:AGIFile) {
		// Skip the first two bytes, which are unknown bytes.
		loopCount = file.data.get(2);
		var descriptionLocation = BitConverter.toInt(file.data, 3);
		if (descriptionLocation > 0)
			description = sage.agi.helpers.AGIStringHelper.getString(file.data, descriptionLocation);

		// Read the loop header positions
		// Loop indices start 5 bytes past the start of the file and are two bytes wide
		var offset = 5;
		for (loopIndex in 0...loopCount)
			loopLocations[loopIndex] = BitConverter.toInt(file.data, offset + (loopIndex * 2));
	}

	private function readLoopHeaders(file:AGIFile) {
		// Read the loop header
		for (loopIndex in 0...loopCount) {
			var loopLocation = loopLocations[loopIndex];
			celsInLoopCount[loopIndex] = file.data.get(loopLocation++);

			// Read the cel positions in each loop.
			for (celIndex in 0...celsInLoopCount[loopIndex])
				cellLocations[loopIndex][celIndex] = BitConverter.toInt(file.data, loopLocation + (celIndex * 2));
		}
	}

	private function readCelHeader(file:AGIFile) {}

	public function new(file:AGIFile) {
		initialize();
		loadViewHeader(file);
		readLoopHeaders(file);
		readCelHeader(file);
	}

	public function getViewLoops() {}
}

class ViewLoop {
	public var loopID(default, set):Int;

	private function set_loopID(value:Int) {
		return loopID = value;
	}

	private var loopCels(default, set):Vector<ViewCell>;

	private function set_loopCels(value:Vector<ViewCell>) {
		return loopCels = value;
	}

	public function new(loopID:Int) {}
}

class ViewCell {}
