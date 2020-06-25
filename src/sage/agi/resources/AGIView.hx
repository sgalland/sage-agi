package sage.agi.resources;

import sage.agi.objects.ViewFlags.Cycle;
import haxe.ds.Vector;
import sage.agi.resources.AGIFile;
import sage.core.BitConverter;
import sage.core.BitSet;
import sage.agi.helpers.AGIColor;
import sage.agi.objects.ViewFlags.ViewFlags;
import sage.agi.objects.ViewFlags.Direction;
import sage.agi.objects.ViewFlags.Motion;

class AGIView {
	private static inline var MAX_CEL:Int = 255;

	private var loopCount:Int;
	private var description:String;
	private var cellLocations:Vector<Vector<Int>>;
	private var loopLocations:Vector<Int>;
	private var celsInLoopCount:Vector<Int>;
	private var viewLoops:Array<ViewLoop>;

	private function initialize() {
		cellLocations = new Vector(MAX_CEL);
		for (i in 0...cellLocations.length)
			cellLocations[i] = new Vector(MAX_CEL);

		loopLocations = new Vector(MAX_CEL);
		celsInLoopCount = new Vector(MAX_CEL);
		viewLoops = new Array<ViewLoop>();
	}

	private function loadViewHeader(file:AGIFile) {
		// Skip the first two bytes, which are unknown bytes.
		loopCount = file.data[2];
		var descriptionLocation = BitConverter.toInt(file.data, 3);
		if (descriptionLocation > 0)
			description = sage.agi.helpers.AGIStringHelper.getString(file.data, descriptionLocation);

		// Read the loop header positions
		// Loop indices start 5 bytes past the start of the file and are two bytes wide
		var offset:Int = 5;
		for (loopIndex in 0...loopCount)
			loopLocations[loopIndex] = BitConverter.toInt(file.data, offset + (loopIndex * 2));
	}

	private function readLoopHeaders(file:AGIFile) {
		// Read the loop header
		for (loopIndex in 0...loopCount) {
			var loopLocation:Int = loopLocations[loopIndex];
			celsInLoopCount[loopIndex] = file.data[loopLocation++];

			// Read the cel positions in each loop.
			for (celIndex in 0...celsInLoopCount[loopIndex])
				cellLocations[loopIndex][celIndex] = BitConverter.toInt(file.data, loopLocation + (celIndex * 2));
		}
	}

	private function readCellHeader(file:AGIFile) {
		for (loopIndex in 0...loopCount) {
			var viewLoop:ViewLoop = new ViewLoop(loopIndex);

			for (cellIndex in 0...celsInLoopCount[loopIndex]) {
				var offset:Int = 0;
				var cellPosition:Int = loopLocations[loopIndex] + cellLocations[loopIndex][cellIndex];
				var width:Int = file.data[cellPosition] * 2;
				var height:Int = file.data[cellPosition + ++offset];

				var bitset:BitSet = new BitSet(8, file.data[cellPosition + ++offset]);
				var transparentColor:Int = bitset.getRangeByte(0, 3);
				var mirroredLoopId:Int = bitset.getRangeByte(4, 6);
				var isMirrored:Bool = bitset[7] == 1 && mirroredLoopId != loopIndex;

				var pixelData:Array<Int> = new Array<Int>();
				for (cellDataIndex in 0...height) {
					var x = 0;
					var chunk = 0;

					while ((chunk = file.data[cellPosition + ++offset]) != 0) {
						var bitArray = new BitSet(8, chunk);

						var pixelCount = bitArray.getRangeByte(0, 3);
						var pixelColor = bitArray.getRangeByte(4, 7);
						var maxPixels = x + pixelCount * 2;

						if (!isMirrored) {
							while (x < maxPixels) {
								pixelData[(cellDataIndex * width) + x] = pixelColor;
								pixelData[(cellDataIndex * width) + x + 1] = pixelColor;
								x += 2;
							}
						} else {
							while (x < maxPixels) {
								pixelData[(cellDataIndex * width) + width - x - 1] = pixelColor;
								pixelData[(cellDataIndex * width) + width - x - 2] = pixelColor;
								x += 2;
							}
						}
					}
				}

				viewLoop.loopCells.push(new ViewCell(AGIColor.getColorByDosColor(transparentColor), width, height, isMirrored, pixelData, mirroredLoopId));
			}

			viewLoops.push(viewLoop);
		}
	}

	public function new(file:AGIFile) {
		initialize();
		loadViewHeader(file);
		readLoopHeaders(file);
		readCellHeader(file);
	}

	public function getViewLoops() {
		return viewLoops;
	}
}

class ViewLoop {
	public var loopID:Int;
	public var loopCells:Array<ViewCell>;

	public function new(loopID:Int) {
		this.loopID = loopID;
		this.loopCells = new Array<ViewCell>();
	}
}

class ViewCell {
	public var width:Int;
	public var height:Int;
	public var isMirrored:Bool;
	public var mirroredLoopId:Int;
	public var data:Array<Int>;
	public var transparentColor:AGIColor;

	public function new(transparentColor:AGIColor, width:Int, height:Int, isMirrored:Bool, data:Array<Int>, mirroredLoopId:Int) {
		this.transparentColor = transparentColor;
		this.width = width;
		this.height = height;
		this.isMirrored = isMirrored;
		this.data = data;
		this.mirroredLoopId = mirroredLoopId;
	}
}

/**
	An instance of a view object that can be animated, placed in a room, etc.
**/
typedef ViewObject = {
	// TODO: Validate
	@:optional var stepTime:Int;

	/**
		Position on the X axis.
	**/
	@:optional var x:Int;

	/**
		Position on the X axis.
	**/
	@:optional var y:Int;

	/**
		The view associated with this view object.
	**/
	@:optional var currentView:Int;

	/**
	    ID of the view to reference
	**/
	@:optional var view:Int;
	// TODO: I don't think this is needed, validate
	@:optional var pointerToViewData:Int;
	@:optional var loop:Int;
	@:optional var numberOfLoops:Int;
	// TODO: I don't think this is needed, validate
	@:optional var pointerToStartOfLoopData:Int;

	/**
		Current Cel being rendered.
	**/
	@:optional var currentCell:Int;

	/**
		Count of cels
	**/
	@:optional var numberOfCels:Int;

	// TODO: I don't think this is needed, validate
	@:optional var pointerToStartOfCelData:Int;
	// TODO: I don't think this is needed, validate
	@:optional var pointerToStartOfCelData2:Int;

	/**
		Copy of X position (why????)
	**/
	@:optional var x2:Int;

	/**
		Copy of Y position (why????)
	**/
	@:optional var y2:Int;

	@:optional var xSize:Int;
	@:optional var ySize:Int;
	@:optional var stepSize:Int;
	// Stored twice???
	@:optional var cycleTime:Int;
	@:optional var direction:Direction;
	@:optional var motion:Motion;
	@:optional var cycle:Cycle;
	@:optional var priority:Int;

	/**
		Flags that indicate the state of the view.
	**/
	@:optional var viewFlags:ViewFlags;
}

// TODO: Add documentation
