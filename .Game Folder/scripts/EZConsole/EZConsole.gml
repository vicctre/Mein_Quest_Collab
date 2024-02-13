
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

console_add_command({
	name: "coins",
	short: "coins",
	desc: "Set coins count",
	args: ["number"],
	args_req: [true],
	args_desc: ["Coins count"],
	callback: ConsoleCoins
})

