package sage.agi.screen;

/**
	Set of constants that define the boundaries of the screen.
**/
class ScreenBoundaries {
	public static final TOP_EDGE = 0;
	public static final BOTTOM_EDGE = 167;
	public static final LEFT_EDGE = 0;
	public static final RIGHT_EDGE = 159;
	public static final SCREEN_TOP = 0;
	public static final SCREEN_LEFT = 0;
	public static final SCREEN_RIGHT = 159;
	public static final FALL_THROUGH = 200;
	public static final DEFAULT_HORIZON = 36;
}

/**
	Defines the location of the screen that is indicated in Variable(2)
**/
class ScreenLocation {
	public static final SCREEN_TOP = 1;
	public static final SCREEN_RIGHT = 2;
	public static final SCREEN_BOTTOM = 3;
	public static final SCREEN_LEFT = 4;
}
