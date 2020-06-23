package sage.agi.resources;

import haxe.ds.Vector;
import sage.agi.helpers.AGIColor;
import haxe.ds.GenericStack;

/**
	Enumeration of drawing commands used when composing an AGIPicture.
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Pic#General_actions
**/
@:enum
abstract DrawingCommands(Int) {
	public inline function new(command:Int) {
		this = command;
	}

	/**
		Changes the current drawing color and enables drawing on the picture screen.
	**/
	var ChangePictureAndEnableDraw = 0xF0;

	/**
		Disables drawing.
	**/
	var DisablePictureDraw = 0xF1;

	/**
		Changes the current drawing color and enables drawing on the priority screen.
	**/
	var ChangePriorityColorAndEnablePriorityDraw = 0xF2;

	/**
		Disables drawing on the priority screen.
	**/
	var DisablePriorityDraw = 0xF3;

	/**
		Drawing command that has the Y axis as the main axis: x, y, y1, x1, y2, x2, y3, x3...
	**/
	var DrawYCorner = 0xF4;

	/**
		Drawing command that has the X axis as the main axis: x, y, x1, y1, x2, y2, x3, y3...
	**/
	var DrawXCorner = 0xF5;

	/**
		Draws a line between two points.
	**/
	var AbsoluteLine = 0xF6;

	/**
		Draws a lines between two points as offsets. NOTE: Update this to be more accurate.
	**/
	var RelativeLine = 0xF7;

	/**
		Flood fills a single color to a given area.
	**/
	var Fill = 0xF8;

	/**
		Changes the pen size and the type of pen style (solid, splatter, circle, rectangle).
	**/
	var ChangePenSizeAndStyle = 0xF9;

	/**
		Pen drawing command.
	**/
	var PlotWithPen = 0xFA;

	/**
		Indicates that the end of the picture has been reached and there are no more drawing commands.
	**/
	var EndOfPicture = 0xFF;
}

class AGIPicture {
	static inline var WIDTH:Int = 320;
	static inline var HEIGHT:Int = 200;
	static inline var EMPTY:Int = 0xFF;

	static final CIRCLE_MAP:haxe.ds.ReadOnlyArray<Array<Int>> = [
		[0x80],
		[0xfc],
		[0x5f, 0xf4],
		[0x66, 0xff, 0xf6, 0x60],
		[0x23, 0xbf, 0xff, 0xff, 0xee, 0x20],
		[0x31, 0xe7, 0x9e, 0xff, 0xff, 0xde, 0x79, 0xe3, 0x00],
		[0x38, 0xf9, 0xf3, 0xef, 0xff, 0xff, 0xff, 0xfe, 0xf9, 0xf3, 0xe3, 0x80],
		[
			0x18, 0x3c, 0x7e, 0x7e, 0x7e, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7e, 0x7e, 0x7e, 0x3c, 0x18
		]
	];

	static final SPLATTER_MAP:haxe.ds.ReadOnlyArray<Int> = [
		0x20, 0x94, 0x02, 0x24, 0x90, 0x82, 0xa4, 0xa2,
		0x82, 0x09, 0x0a, 0x22, 0x12, 0x10, 0x42, 0x14,
		0x91, 0x4a, 0x91, 0x11, 0x08, 0x12, 0x25, 0x10,
		0x22, 0xa8, 0x14, 0x24, 0x00, 0x50, 0x24, 0x04
	];

	static final SPLATTER_START_POSITIONS:haxe.ds.ReadOnlyArray<Int> = [
		0x00, 0x18, 0x30, 0xc4, 0xdc, 0x65, 0xeb, 0x48,
		0x60, 0xbd, 0x89, 0x05, 0x0a, 0xf4, 0x7d, 0x7d,
		0x85, 0xb0, 0x8e, 0x95, 0x1f, 0x22, 0x0d, 0xdf,
		0x2a, 0x78, 0xd5, 0x73, 0x1c, 0xb4, 0x40, 0xa1,
		0xb9, 0x3c, 0xca, 0x58, 0x92, 0x34, 0xcc, 0xce,
		0xd7, 0x42, 0x90, 0x0f, 0x8b, 0x7f, 0x32, 0xed,
		0x5c, 0x9d, 0xc8, 0x99, 0xad, 0x4e, 0x56, 0xa6,
		0xf7, 0x68, 0xb7, 0x25, 0x82, 0x37, 0x3a, 0x51,
		0x69, 0x26, 0x38, 0x52, 0x9e, 0x9a, 0x4f, 0xa7,
		0x43, 0x10, 0x80, 0xee, 0x3d, 0x59, 0x35, 0xcf,
		0x79, 0x74, 0xb5, 0xa2, 0xb1, 0x96, 0x23, 0xe0,
		0xbe, 0x05, 0xf5, 0x6e, 0x19, 0xc5, 0x66, 0x49,
		0xf0, 0xd1, 0x54, 0xa9, 0x70, 0x4b, 0xa4, 0xe2,
		0xe6, 0xe5, 0xab, 0xe4, 0xd2, 0xaa, 0x4c, 0xe3,
		0x06, 0x6f, 0xc6, 0x4a, 0xa4, 0x75, 0x97, 0xe1
	];

	var pictureBuffer:Vector<Int>;
	var priorityBuffer:Vector<Int>;
	var file:AGIFile;
	var vecPos:Int;
	var patNum:Int;
	var patCode:Int;
	var picColor:Int;
	var priotityColor:Int;
	var bitPos:Int;
	var penX1:Int;
	var penY1:Int;
	var penSize:Int;
	var resNum:Int;
	var isPicDrawingEnabled:Bool;
	var isPriorityDrawingEnabled:Bool;
	var isDrawing:Bool;

	public function new(file:AGIFile) {
		this.file = file;
		render();
	}

	// =========================================================================
	// STACK
	// =========================================================================
	var spos:Int = 0;
	var QMAX:Int = 4000;
	var rpos:Int = 4000;
	var buf:Vector<Int> = new Vector<Int>(4001);

	function qstore(q:Int):Void {
		if (spos + 1 == rpos || (spos + 1 == QMAX && rpos == 0)) {
			return;
		}
		buf[spos] = q;
		spos++;
		if (spos == QMAX)
			spos = 0; /* loop back */
	}

	function qretrieve():Int {
		if (rpos == QMAX)
			rpos = 0; /* loop back */
		if (rpos == spos) {
			return EMPTY;
		}
		rpos++;
		return buf[rpos - 1];
	}

	// =========================================================================
	// END STACK
	// =========================================================================

	function initializeDrawingSurface() {
		var bufferSize = WIDTH * HEIGHT;

		var color = AGIColor.getColorByDosColor(15);
		pictureBuffer = new Vector<Int>(bufferSize);
		for (i in 0...bufferSize)
			pictureBuffer[i] = color.dosColor;

		color = AGIColor.getColorByDosColor(4);
		priorityBuffer = new Vector<Int>(bufferSize);
		for (i in 0...bufferSize)
			priorityBuffer[i] = color.dosColor;
	}

	public function getPicturePixels():Vector<Int> {
		return pictureBuffer;
	}

	public function getPriorityPixels():Vector<Int> {
		return priorityBuffer;
	}

	// =========================================================================
	// Pixel Manipulation
	// =========================================================================
	function getPicturePixel(x:Int, y:Int):Int {
		var vx:Int = (x << 1);
		var vy:Int = y;
		if (vx > 319 || vy > 199)
			return 15;

		var currentPixelColor:Int = pictureBuffer[vx + vy * WIDTH];
		var color:AGIColor = AGIColor.getColorByDosColor(currentPixelColor);
		return color.dosColor;
	}

	function getPriorityPixel(x:Int, y:Int):Int {
		var vx:Int = (x << 1);
		var vy:Int = y;
		if (vx > 319 || vy > 199)
			return 4;

		var currentPixelColor:Int = priorityBuffer[vx + vy * WIDTH];
		var color:AGIColor = AGIColor.getColorByDosColor(currentPixelColor);
		return color.dosColor;
	}

	function setPixel(x:Float, y:Float) {
		var xx:Int = Std.int(x);
		var x1:Int = xx << 1;
		if (x1 > 319)
			return;
		if (y > 199)
			return;

		if (isPicDrawingEnabled) {
			pictureBuffer[Std.int(x1 + y * WIDTH)] = picColor;
			pictureBuffer[Std.int(x1 + 1 + y * WIDTH)] = picColor;
		} else if (isPriorityDrawingEnabled) {
			priorityBuffer[Std.int(x1 + y * WIDTH)] = priotityColor;
			priorityBuffer[Std.int(x1 + 1 + y * WIDTH)] = priotityColor;
		}
	}

	function fill(x:Int, y:Int) {
		var x1:UInt; // Use UInt8 to ensure correct variable overflow
		var y1:UInt; // Use UInt8 to ensure correct variable overflow
		rpos = spos = 0;

		qstore(x);
		qstore(y);

		while (true) {
			x1 = qretrieve();
			y1 = qretrieve();

			if (x1 == EMPTY || y1 == EMPTY)
				break;
			else {
				if (canFill(x1, y1)) {
					setPixel(x1, y1);

					if (canFill(x1, y1 - 1) && y1 != 0) {
						qstore(x1);
						qstore(y1 - 1);
					}
					if (canFill(x1 - 1, y1) && x1 != 0) {
						qstore(x1 - 1);
						qstore(y1);
					}
					if (canFill(x1 + 1, y1) && x1 != 159) {
						qstore(x1 + 1);
						qstore(y1);
					}
					if (canFill(x1, y1 + 1) && y1 != 167) {
						qstore(x1);
						qstore(y1 + 1);
					}
				}
			}
		}
	}

	private function canFill(x:UInt, y:UInt) {
		if (!isPicDrawingEnabled && !isPriorityDrawingEnabled)
			return false;
		if (picColor == 15)
			return false;
		if (!isPriorityDrawingEnabled)
			return (getPicturePixel(x, y) == 15);
		if (isPriorityDrawingEnabled && !isPicDrawingEnabled)
			return (getPriorityPixel(x, y) == 4);
		return (getPicturePixel(x, y) == 15);
	}

	// =========================================================================
	// Drawing Actions
	// =========================================================================
	function drawLine(x1:Int, y1:Int, x2:Int, y2:Int) {
		var x:Float = x1;
		var y:Float = y1;

		var height:Int = y2 - y1;
		var width:Int = x2 - x1;
		var addX:Float = height == 0 ? height : width / Math.abs(height);
		var addY:Float = width == 0 ? width : height / Math.abs(width);

		if (Math.abs(width) > Math.abs(height)) {
			addX = width == 0 ? 0 : width / Math.abs(width);
			while (x != x2) {
				setPixel(round(x, addX), round(y, addY));
				x += addX;
				y += addY;
			}
			setPixel(x2, y2);
		} else {
			addY = height == 0 ? 0 : height / Math.abs(height);
			while (y != y2) {
				setPixel(round(x, addX), round(y, addY));
				x += addX;
				y += addY;
			}
			setPixel(x2, y2);
		}
	}

	function drawYCorner() {
		var x1:Int = file.data[vecPos++];
		var y1:Int = file.data[vecPos++];
		var x2:Int;
		var y2:Int;

		setPixel(x1, y1);

		while (true) {
			y2 = file.data[vecPos++];
			if (y2 >= 0xF0)
				break;
			drawLine(x1, y1, x1, y2);
			y1 = y2;
			x2 = file.data[vecPos++];
			if (x2 >= 0xF0)
				break;
			drawLine(x1, y1, x2, y1);
			x1 = x2;
		}

		vecPos--;
	}

	function drawXCorner() {
		var x1:Int = file.data[vecPos++];
		var y1:Int = file.data[vecPos++];
		var x2:Int;
		var y2:Int;

		setPixel(x1, y1);

		while (true) {
			x2 = file.data[vecPos++];
			if (x2 >= 0xF0)
				break;
			drawLine(x1, y1, x2, y1);
			x1 = x2;
			y2 = file.data[vecPos++];
			if (y2 >= 0xF0)
				break;
			drawLine(x1, y1, x1, y2);
			y1 = y2;
		}

		vecPos--;
	}

	function absoluteLine() {
		var x1:Int = file.data[vecPos++];
		var y1:Int = file.data[vecPos++];
		var x2:Int;
		var y2:Int;

		setPixel(x1, y1);

		while ((x2 = file.data[vecPos++]) < 0xF0 && (y2 = file.data[vecPos++]) < 0xF0) {
			drawLine(x1, y1, x2, y2);
			x1 = x2;
			y1 = y2;
		}

		vecPos--;
	}

	function relativeLine() {
		var x1:Int = file.data[vecPos++];
		var y1:Int = file.data[vecPos++];
		var x2:Int;
		var y2:Int;
		var disp:Int;
		var dx:Int;
		var dy:Int;

		setPixel(x1, y1);

		while (true) {
			disp = file.data[vecPos++];
			if (disp >= 0xF0)
				break;
			dx = ((disp & 0xF0) >> 4) & 0x0F;
			dy = (disp & 0x0F);
			if ((dx & 0x08) != 0)
				dx = (-1) * (dx & 0x07);
			if ((dy & 0x08) != 0)
				dy = (-1) * (dy & 0x07);
			drawLine(x1, y1, x1 + dx, y1 + dy);
			x1 += dx;
			y1 += dy;
		};

		vecPos--;
	}

	function fillCommand() {
		var x:Int;
		var y:Int;

		while (true) {
			if ((x = file.data[vecPos++]) >= 0xF0)
				break;
			if ((y = file.data[vecPos++]) >= 0xF0)
				break;
			fill(x, y);
		}

		vecPos--;
	}

	function plotPattern(x:Int, y:Int) {
		// if (patNum >= splatterMap.Length - 1) patNum = 0;
		var circlePos = 0;
		/*penX1, peny1, */
		var penSize:Int;
		bitPos = SPLATTER_START_POSITIONS[patNum];

		penSize = (patCode & 7);

		if (x < ((penSize / 2) + 1))
			x = Std.int(((penSize / 2) + 1));
		else if (x > 160 - ((penSize / 2) + 1))
			x = Std.int((160 - ((penSize / 2) + 1)));
		if (y < penSize)
			y = penSize;
		else if (y >= 168 - penSize)
			y = (167 - penSize);

		for (penY1 in (y - penSize)...(y + penSize)) {
			var px = x - Math.ceil(penSize / 2);
			var pxx = x + Math.floor(penSize / 2);
			for (penX1 in (px...pxx)) {
				if ((patCode & 0x10) != 0) {/* Square */
					plotPatternPoint();
				} else {/* Circle */
					if (((CIRCLE_MAP[patCode & 7][circlePos >> 3] >> (7 - (circlePos & 7))) & 1) != 0) {
						plotPatternPoint();
					}
					circlePos++;
				}
			}
		}
	}

	private function plotPatternPoint() {
		if ((patCode & 0x20) != 0) {
			if (((SPLATTER_MAP[bitPos >> 3] >> (7 - (bitPos & 7))) & 1) != 0)
				setPixel(penX1, penY1);
			bitPos++;
			if (bitPos == 0xff)
				bitPos = 0;
		} else
			setPixel(penX1, penY1);
	}

	private function plotBrush() {
		var x1:Int;
		var y1:Int;

		while (true) {
			if ((patCode & 0x20) != 0) {
				if (((patNum = file.data[vecPos++]) >= 0xF0))
					break;
				patNum = (patNum >> 1 & 0x7f);
			}
			if ((x1 = file.data[vecPos++]) >= 0xF0)
				break;
			if ((y1 = file.data[vecPos++]) >= 0xF0)
				break;
			plotPattern(x1, y1);
		}

		vecPos--;
	}

	public function render() {
		initializeDrawingSurface();
		vecPos = 0;
		isDrawing = true;
		do {
			var action:DrawingCommands = new DrawingCommands(file.data[vecPos++]);
			switch action {
				case DrawingCommands.EndOfPicture:
					isDrawing = false;
				case DrawingCommands.ChangePictureAndEnableDraw:
					{
						picColor = file.data[vecPos++];
						isPicDrawingEnabled = true;
					}
				case DrawingCommands.DisablePictureDraw:
					isPicDrawingEnabled = false;
				case DrawingCommands.ChangePriorityColorAndEnablePriorityDraw:
					{
						priotityColor = file.data[vecPos++];
						isPriorityDrawingEnabled = true;
					}
				case DrawingCommands.DisablePriorityDraw:
					isPriorityDrawingEnabled = false;
				case DrawingCommands.DrawYCorner:
					drawYCorner();
				case DrawingCommands.DrawXCorner:
					drawXCorner();
				case DrawingCommands.AbsoluteLine:
					absoluteLine();
				case DrawingCommands.RelativeLine:
					relativeLine();
				case DrawingCommands.Fill:
					fillCommand();
				case DrawingCommands.ChangePenSizeAndStyle:
					patCode = file.data[vecPos++];
				case DrawingCommands.PlotWithPen:
					plotBrush();
				default:
					isDrawing = false;
			}
		} while (vecPos < file.data.length && isDrawing);
	}

	// =========================================================================
	// MATH OPERATIONS
	// =========================================================================
	function round(num:Float, dirn:Float):Int {
		if (dirn > 0)
			return ((num - Math.floor(num) <= 0.501) ? Math.floor(num) : Math.ceil(num));
		return ((num - Math.floor(num) < 0.499) ? Math.floor(num) : Math.ceil(num));
	}
}
