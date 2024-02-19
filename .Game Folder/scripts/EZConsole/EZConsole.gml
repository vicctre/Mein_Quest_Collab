
function ConsoleCoins(params) {
	//catch requires format of catch(exception)
	var coins
	try {
		coins = int64(params[0])
	} catch(e) {
		console_write_log("Should be integer value", EZ_CONSOLE_MSG_TYPE.ERROR)
		return;
	}
	global.coins = coins
}

function ConsoleResetProgress() {
	if !instance_exists(oStageManager) {
		console_write_log("oStageManager doesn't exist", EZ_CONSOLE_MSG_TYPE.ERROR)
		return;
	}
	oStageManager.ResetProgress()
	console_write_log("Game progress is reset", EZ_CONSOLE_MSG_TYPE.INFO)
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

console_add_command({
	name: "reset_progress",
	short: "resp",
	desc: "Reset game progress",
	args: [],
	args_req: [],
	args_desc: [],
	callback: ConsoleResetProgress
})

