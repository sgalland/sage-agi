package sage.agi.logic.commands;

import sage.agi.logic.LogicProcessor.Args;
import sage.agi.interpreter.AGIInterpreter;

/**
	Implementation of Program Control comands
	@see https://wiki.scummvm.org/index.php?title=AGI/Specifications/Logic#Program_control_commands
**/
class ProgramControl {
	/**
		Stops rendering the current room and all animations and loads a new room.
		@param arg1 Room number
	**/
	public static function new_room(args:Args) {
		// TODO: Not completely implemented.

		AGIInterpreter.instance.NEW_ROOM = true;

		// 1. Commands stop.update and unanimate are issued to all objects;
		for (key in AGIInterpreter.instance.OBJECTS.keys())
			ObjectMotionControl.stop_update({arg1: key});
		ObjectControl.unanimate_all();
		// 2. All resources except Logic(0) are discarded;
		for (i in 0...AGIInterpreter.MAX_RESOURCES) {
			if (i != 0 && AGIInterpreter.instance.LOGICS.exists(i)) // Keep logic 0
				AGIInterpreter.instance.LOGICS.set(i, null);

			// Clear other resource types

			if (AGIInterpreter.instance.PICTURES.exists(i))
				AGIInterpreter.instance.PICTURES.set(i, null);

			if (AGIInterpreter.instance.VIEWS.exists(i))
				AGIInterpreter.instance.VIEWS.set(i, null);

			// TODO: Clear sounds
		}
		// 3. Command player.control is issued;
		ObjectMotionControl.player_control();
		// 4. unblock command is issued;
		// ObjectMotionControl.unblock();
		// 5. set.horizon(36) command is issued;
		ObjectMotionControl.set_horizon({arg1: 36});
		// 6. v1 is assigned the value of v0; v0 is assigned n (or the value of vn when the command is new.room.v); v4 is assigned 0; v5 is assigned 0; v16 is assigned the ID number of the VIEW resource that was associated with Ego (the player character).
		AGIInterpreter.instance.VARIABLES[1] = AGIInterpreter.instance.VARIABLES[0]; // Assign current room to previous room
		AGIInterpreter.instance.VARIABLES[0] = args.arg1; // Assign the new room to v0
		AGIInterpreter.instance.VARIABLES[4] = 0; // Reset the object id of the object that touched the border
		AGIInterpreter.instance.VARIABLES[5] = 0; // Code of the border that was touched by object v4
		// TODO: v16 is assigned the value of the view resource associated with ego
		// 7. Logic(i) resource is loaded where i is the value of v0 !
		Resource.load_logic({arg1: AGIInterpreter.instance.VARIABLES[0]});
		// 8. Set Ego coordinates according to v2:
		//    if Ego touched the bottom edge, put it on the horizon;
		//    if Ego touched the top edge, put it on the bottom edge of the screen;
		//    if Ego touched the right edge, put it at the left and vice versa.
		// TODO: Set Ego's coordinates based on edge touched
		// 1. v2 is assigned 0 (meaning Ego has not touched any edges).
		AGIInterpreter.instance.VARIABLES[2] = 0;
		// 2. f5 is set to 1 (meaning in the first interpreter cycle after the new_room command all initialization parts of all logics loaded and called from the initialization part of the new room's logic will be called. In the subsequent cycle f5 is reset to 0 (see section Interpreter work cycle and the source of the "Thunderstorm" program. This is very important!).
		AGIInterpreter.instance.FLAGS[5] = true;
		// 3. Clear keyboard input buffer and return to the main AGI loop.
		AGIInterpreter.instance.KEYBOARD_BUFFER = [];
	}

	/**
		Loads a new room, with the room number stored in vn.
		@param args Variable number to retrieve the room number.
	**/
	public static function new_room_v(args:Args) {
		var room:UInt = AGIInterpreter.instance.VARIABLES[args.arg1];
		new_room({arg1: room});
	}
}
