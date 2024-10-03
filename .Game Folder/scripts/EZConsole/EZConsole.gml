
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

function ConsoleShowPopUp() {
    oUIPopUpMessage.PopUp("Hey there, since the wait for Demo 2 was quite some time, we wanted to give you one more thing to do! The first stage of World 2 has been unlocked, give it a go if you want to see more")
    oUIPopUpMessage.PopUp("The Sister Spirit has granted you a new ability: The Pogo Attack! Press down and attack midair to bounce off enemies and objects. This can be used in previous stages too, have fun! ")
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

console_add_command({
	name: "popup",
	short: "popup",
	desc: "show test pop up messages",
	args: [],
	args_req: [],
	args_desc: [],
	callback: ConsoleShowPopUp
})


