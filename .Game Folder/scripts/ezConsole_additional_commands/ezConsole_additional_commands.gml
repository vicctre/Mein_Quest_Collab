
function __GetAllRoomNames() {
	var ind = 0
	var rooms = []
	while room_exists(ind) {
		array_push(rooms, room_get_name(ind))
		ind++
	}
	return rooms
}

function ConsoleGoTo(params) {
	var room_name = params[0]
	var index = asset_get_index(room_name)
	if !room_exists(index) {
		console_write_log(string("No such room {0}", room_name), EZ_CONSOLE_MSG_TYPE.ERROR)
		return
	}
	//show_debug_message("ConsoleGoTo {0} --> {1}", room_name, index)
	SlideTransition(TRANS_MODE.GOTO, index)
}

function ConsoleRoomSpeed(params) {
	var sp = max(1, params[0])
	game_set_speed(sp, gamespeed_fps)
}

// call from __EzConsole__ object to prevent
// undefined global variable error
function ConsoleInitAdditionalCommands() {
	console_add_command({
		name: "goto",
		short: "goto",
		desc: "Go to specified room",
		args: ["room"],
		args_req: [true],
		args_desc: ["Boolean flag to enable or disable the fps counter."],
		callback: ConsoleGoTo,
		args_suggestions: [
			__GetAllRoomNames()
		]
	})

	console_add_command({
		name: "roomsp",
		short: "rsp",
		desc: "Set room speed",
		args: ["number"],
		args_req: [true],
		args_desc: ["Room speed (fps)"],
		callback: ConsoleRoomSpeed
	})

}
