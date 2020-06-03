package sage.agi.logic.commands;

import sage.agi.interpreter.AGIInterpreter;

/**
	Implementation of Program Control comands
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Program_control_commands
**/
class ProgramControl {
	/**
		Stops rendering the current room and all animations and loads a new room.
		@param n
	**/
	public static function new_room(n:UInt) {
		// TODO: Not actually implemented!!!

		// 1. Commands stop.update and unanimate are issued to all objects;
		// 2. All resources except Logic(0) are discarded;
		// 3. Command player.control is issued;
		// 4. unblock command is issued;
		// 5. set.horizon(36) command is issued;
		ObjectMotionControl.set_horizon(36);
		// 6. v1 is assigned the value of v0; v0 is assigned n (or the value of vn when the command is new.room.v); v4 is assigned 0; v5 is assigned 0; v16 is assigned the ID number of the VIEW resource that was associated with Ego (the player character).
		// 7. Logic(i) resource is loaded where i is the value of v0 !
		// 8. Set Ego coordinates according to v2:
		//    if Ego touched the bottom edge, put it on the horizon;
		//    if Ego touched the top edge, put it on the bottom edge of the screen;
		//    if Ego touched the right edge, put it at the left and vice versa.
		// 1. v2 is assigned 0 (meaning Ego has not touched any edges).
		AGIInterpreter.instance.VARIABLES[2] = 0;
		// 2. f5 is set to 1 (meaning in the first interpreter cycle after the new_room command all initialization parts of all logics loaded and called from the initialization part of the new room's logic will be called. In the subsequent cycle f5 is reset to 0 (see section Interpreter work cycle and the source of the "Thunderstorm" program. This is very important!).
		AGIInterpreter.instance.FLAGS[5] = true;
		// 3. Clear keyboard input buffer and return to the main AGI loop.
	}

	// TODO: Implement Program Control commands
}
