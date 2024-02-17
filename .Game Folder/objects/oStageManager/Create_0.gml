
stages_data = {
	W1_1_part1: {
		adv_logs: {
			Mein: {
				order: 0,
				unlocked: false
			}
		}
	},
	W1_2_part1: {
		adv_logs: {
			Genull: {
				order: 0,
				unlocked: false
			},
			Tuffull: {
				order: 1,
				unlocked: false
			}
		}
	},
	W1_3_part1: {
		adv_logs: {
			Genull: {
				order: 0,
				unlocked: false
			},
			Tuffull: {
				order: 1,
				unlocked: false
			},
			Mein: {
				order: 2,
				unlocked: false
			}
		}
	}
}

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

function GetStageData(stage) {
	if !is_string(stage) {
		stage = room_get_name(stage)
	}
	return stages_data[$ stage]
}

function MapStageName(name) {
	// W1_1_part4 --> W1_1_part1
	return string_copy(name, 0, 5) + "part1"
}

function UnlockAdvLog(stage, name) {
	stage = MapStageName(room_get_name(stage))
	var stage_logs = stages_data[$ stage].adv_logs
	if variable_struct_exists(stage_logs, name) {
		stage_logs[$ name].unlocked = true
		return
	}
	show_debug_message("Failed to find adv log {} in stage {}", name, stage)
}
