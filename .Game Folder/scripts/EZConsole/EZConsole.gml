
function ConsoleGoTo(params) {
	var room_name = params[0]
	var index = asset_get_index(room_name)
	if index == -1 {
		console_write_log(string("No such room {0}", room_name), EZ_CONSOLE_MSG_TYPE.ERROR)
		return
	}
	//show_debug_message("ConsoleGoTo {0} --> {1}", room_name, index)
	SlideTransition(TRANS_MODE.GOTO, index)
}

console_add_command({
	name: "goto",
	short: "goto",
	desc: "Go to specified room",
	args: ["room"],
	args_req: [true],
	args_desc: ["Boolean flag to enable or disable the fps counter."],
	callback: ConsoleGoTo,
	args_suggestions: [
		[
			"W1_1_part1",
			"W1_1_part2",
			"W1_1_part3",
		]
	]
})
