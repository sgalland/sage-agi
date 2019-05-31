package openfl.graphics;

import lime.math.ARGB;
import sage.agi.helpers.AGIColor;

/**
	Class of helper utilities for converting RGB to other color spaces.
**/
class AGIColorConverter {
	/**
		Convert an array of pixels to RGB color space.
		 @param pixels
	**/
	public static function convertPixelsToRGB(pixels:Array<Int>) {
		for (i in 0...pixels.length) {
			var pixel:Int = pixels[i];
			var color:AGIColor = AGIColor.getColorByDosColor(pixel);
			pixels[i] = convertRGBToARGBInteger(color.r, color.g, color.b);
		}
	}

	/**
		Convert individual RGB values to a 32 bit integer.
		@param r Red 0-255
		@param g Greed 0-255
		@param b Blue 0-255
		@return Int
	**/
	public static function convertRGBToARGBInteger(r:Int, g:Int, b:Int):Int {
		var a:Int = 255;
		return ARGB.create(a, r, g, b);
	}
}
