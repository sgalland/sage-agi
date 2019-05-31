package sage.agi.helpers;

/**
	Defines an RGB mapping to a dos color.
**/
class AGIColor {
	static var colors:Array<AGIColor>;

	/**
		RGB value of red.
	**/
	public var r:Int;

	/**
		RGB value of green.
	**/
	public var g:Int;

	/**
		RGB value of blue.
	**/
	public var b:Int;

	/**
		DOS color code.
	**/
	public var dosColor:Int;

	public function new(dosColor:Int, r:Int, g:Int, b:Int) {
		this.r = r;
		this.g = g;
		this.b = b;
		this.dosColor = dosColor;
	}

	/**
		Returns an RGB AGIColor based on a DOS color color.
		 @param dosColor DOS color code as Int
		 @return AGIColor
	**/
	public static function getColorByDosColor(dosColor:Int):AGIColor {
		if (colors == null) {
			AGIColor.colors = new Array<AGIColor>();
			AGIColor.colors.push(new AGIColor(0, 0x00, 0x00, 0x00));
			AGIColor.colors.push(new AGIColor(1, 0x00, 0x00, 168));
			AGIColor.colors.push(new AGIColor(2, 0x00, 168, 0x00));
			AGIColor.colors.push(new AGIColor(3, 0x00, 168, 168));
			AGIColor.colors.push(new AGIColor(4, 168, 0x00, 0x00));
			AGIColor.colors.push(new AGIColor(5, 168, 0x00, 168));
			AGIColor.colors.push(new AGIColor(6, 168, 84, 0x00));
			AGIColor.colors.push(new AGIColor(7, 168, 168, 168));
			AGIColor.colors.push(new AGIColor(8, 84, 84, 84));
			AGIColor.colors.push(new AGIColor(9, 84, 84, 252));
			AGIColor.colors.push(new AGIColor(10, 84, 252, 84));
			AGIColor.colors.push(new AGIColor(11, 84, 252, 252));
			AGIColor.colors.push(new AGIColor(12, 252, 84, 84));
			AGIColor.colors.push(new AGIColor(13, 252, 84, 252));
			AGIColor.colors.push(new AGIColor(14, 252, 252, 84));
			AGIColor.colors.push(new AGIColor(15, 252, 252, 252));
		}

		return AGIColor.colors[dosColor];
	}
}
