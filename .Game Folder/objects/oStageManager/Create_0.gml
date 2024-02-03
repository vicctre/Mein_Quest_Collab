
function SaveFile() : SSave("save") constructor {
	add_value("last_unlocked_stage", SSAVE_TYPE.REAL, real(W1_1_part1))
}

last_unlocked_stage = real(W1_1_part1)

save = new SaveFile()

if save.load("") {
	last_unlocked_stage = save.get("last_unlocked_stage")
} else {
	save.set("last_unlocked_stage", 0)
}

function IsStageUnlocked(index) {
	index = real(index)
	return index <= last_unlocked_stage
}