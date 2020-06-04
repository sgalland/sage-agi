package sage.agi.screen;

/**
	Settings that effect the location of items on the screen. The various lines are effected by the PC text modes.
	@see https://en.wikipedia.org/wiki/Text_mode#PC_common_text_modes
**/
class ScreenSettings {
	/**
		Sets the line of the play area.
	**/
	public var playArea:Int;

	/**
		Sets the location of the input line.
	**/
	public var inputLine:Int;

	/**
		Sets the location of the staus line.
	**/
	public var statusLine:Int;

	/**
		Location of the horizon along the Y axis.
	**/
	public var horizon:Int;

	/**
		Indicates if the status line is displayed.
	**/
	public var displayStatusLine:Bool;

	public function new(playArea:Int, inputLine:Int, statusLine:Int) {
		this.playArea = playArea;
		this.inputLine = inputLine;
		this.statusLine = statusLine;
	}
}
