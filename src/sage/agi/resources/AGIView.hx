package sage.agi.resources;

import haxe.ds.Vector;
import sage.agi.resources.AGIFile;
import sage.core.BitConverter;
import sage.core.BitSet;

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
		loopCount = file.data[2];
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
			celsInLoopCount[loopIndex] = file.data[loopLocation++];

			// Read the cel positions in each loop.
			for (celIndex in 0...celsInLoopCount[loopIndex])
				cellLocations[loopIndex][celIndex] = BitConverter.toInt(file.data, loopLocation + (celIndex * 2));
		}
	}

	private function readCellHeader(file:AGIFile) {
		for (loopIndex in 0...loopCount) {
			var viewLoop:ViewLoop = new ViewLoop(loopIndex);

			for (cellIndex in 0...loopCount) {
				var offset:Int = 0;
				var cellPosition = loopLocations[loopIndex] + cellLocations[loopIndex][cellIndex];
				var width = file.data[cellPosition] * 2;
				var height = file.data[cellPosition + ++offset];

				var bitset:BitSet = new BitSet(8, file.data[cellPosition + ++offset]);
				var transparentColor = bitset.getRangeByte(0, 3);
				var mirroredLoopId = bitset.getRangeByte(4, 6);
				var isMirrored = bitset[7] == 1 && mirroredLoopId != loopIndex;
			}
		}

		// 	for (uint8_t loopIndex = 0; loopIndex < this->loopCount; loopIndex++)
		// {
		// 	ViewLoop viewLoop(loopIndex);

		// 	for (uint8_t celIndex = 0; celIndex < celsInLoopCount[loopIndex]; celIndex++)
		// 	{
		// 		uint16_t offset = 0;
		// 		uint16_t celPosition = this->loopLocations[loopIndex] + this->celLocations[loopIndex][celIndex];
		// 		uint8_t width = file.data[celPosition] * 2;
		// 		uint8_t height = file.data[celPosition + ++offset];

		// 		BitSetHelper<8> bitset(file.data[celPosition + ++offset]);
		// 		uint8_t transparentColor = bitset.get_range_byte(0, 3);
		// 		// this mirroring appears correct but needs to be better tested
		// 		uint8_t mirroredLoopId = bitset.get_range_byte(4, 6);
		// 		bool isMirrored = bitset[7] == 1 && mirroredLoopId != loopIndex;

		// 		std::vector<uint32_t> pixelData(width * height, transparentColor);
		// 		for (uint8_t celDataIndex = 0; celDataIndex < height; celDataIndex++)
		// 		{
		// 			uint16_t x = 0;
		// 			uint8_t chunk = 0;

		// 			while ((chunk = file.data[celPosition + ++offset]) != 0)
		// 			{
		// 				BitSetHelper<8> bitArray(chunk);
		// 				uint8_t pixelCount = bitArray.get_range_byte(0, 3);
		// 				uint8_t pixelColor = bitArray.get_range_byte(4, 7);
		// 				if (!isMirrored)
		// 				{
		// 					for (uint16_t originalCelx = x; x < originalCelx + pixelCount * 2; x += 2)
		// 					{
		// 						pixelData[(celDataIndex * width) + x] = pixelColor;
		// 						pixelData[(celDataIndex * width) + x + 1] = pixelColor;
		// 					}
		// 				}
		// 				else
		// 				{
		// 					for (uint16_t originalCelx = x; x < originalCelx + pixelCount * 2; x += 2)
		// 					{
		// 						pixelData[(celDataIndex * width) + width - x - 1] = pixelColor;
		// 						pixelData[(celDataIndex * width) + width - x - 2] = pixelColor;
		// 					}
		// 				}
		// 			}
		// 		}

		// 		viewLoop.cels().emplace_back(AgiColor::getColorByDosColor(transparentColor), width, height, isMirrored, pixelData, mirroredLoopId);
		// 	}

		// 	viewLoops.push_back(viewLoop);
		// }
	}

	public function new(file:AGIFile) {
		initialize();
		loadViewHeader(file);
		readLoopHeaders(file);
		readCellHeader(file);
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
