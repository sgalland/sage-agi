package sage.agi.text;

import sage.agi.helpers.AGIColor;

/**
	Defines the visual properties of text on the screen.
**/
class TextAttribute {
	/**
		Foreground font color.
	**/
	public var foreground:AGIColor;

	/**
		Background font color.
	**/
	public var background:AGIColor;

	public function new(foreground:AGIColor, background:AGIColor) {
		this.foreground = foreground;
		this.background = background;
	}
}
