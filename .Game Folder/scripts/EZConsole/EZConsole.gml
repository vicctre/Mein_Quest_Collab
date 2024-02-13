
function ConsoleCoins(params) {
	/* COMMENTED OUT SO IT STOPS CRASHING THE GAME SO VICCTRE CAN COMPILE THE GAME
	//catch requires format of catch(exception)
	var coins
	try {
		coins = int64(params[0])
	} catch(e) {
		console_write_log("Should be integer value", EZ_CONSOLE_MSG_TYPE.ERROR)
		return;
	}
	global.coins = coins
	/**/
}

function ConsoleRoomSpeed(params) {
	var sp = max(1, params[0])
	game_set_speed(sp, gamespeed_fps)
}


console_add_command({
	name: "coins",
	short: "coins",
	desc: "Set coins count",
	args: ["number"],
	args_req: [true],
	args_desc: ["Coins count"],
	callback: ConsoleCoins
})

