
default_last_unlocked_stage = real(W1_1_part1)

function DefaultStagesData() {
	/*
	This is adv log save default config.
	It's updated as you collect adv logs.
	order defines adv log displaying order in stage select menu,
	and NOT the order they appear in game - that is set in room editor (see oChest)
	*/

	return {
		W1_1: {
			adv_logs: {
				Mein: {
					order: 0,
					unlocked: false,
                    was_showed_in_adv_log_screen: false
				}
			}
		},
		W1_2: {
			adv_logs: {
				Genull: {
					order: 0,
					unlocked: false,
                    was_showed_in_adv_log_screen: false
				},
				Tuffull: {
					order: 1,
					unlocked: false,
                    was_showed_in_adv_log_screen: false
				},
			}
		},
		W1_3: {
			adv_logs: {
				Genull: {
					order: 0,
					unlocked: false,
                    was_showed_in_adv_log_screen: false
				},
				Tuffull: {
					order: 1,
					unlocked: false,
                    was_showed_in_adv_log_screen: false
				},
				Mein: {
					order: 2,
					unlocked: false,
                    was_showed_in_adv_log_screen: false
				}
			}
		}
	}
}

function SaveFile() : SSave("save") constructor {
	// unlocking stages is saved in RoomStart
	add_value("last_unlocked_stage", SSAVE_TYPE.REAL, real(W1_1_part1))
	add_value("stages_data", SSAVE_TYPE.STRUCT, other.DefaultStagesData)
}

save = new SaveFile()

if save.load("") {
	last_unlocked_stage = save.get("last_unlocked_stage")
	stages_data = save.get("stages_data")
} else {
	last_unlocked_stage = default_last_unlocked_stage
	stages_data = DefaultStagesData()
	save.set("last_unlocked_stage", 0)
	save.set("stages_data", stages_data)
}

function IsStageUnlocked(index) {
	index = real(index)
	return index <= last_unlocked_stage
}

function IsAdventureLogUnlocked(stage, name) {
	return GetStageData(stage).adv_logs[$ name].unlocked
}

function MapStageName(name) {
	// W1_1_part4 --> W1_1
	return string_copy(name, 0, 4)
}

function GetStageData(stage) {
	if !is_string(stage) {
		stage = room_get_name(stage)
	}
	return stages_data[$ MapStageName(stage)]
}

function GetAdvLog(stage, name) {
	return GetStageData(stage).adv_logs[$ name]
}

function GetStageAdvLogNames(stage) {
	/* 
	in order defined in stage_data
	*/
	var logs = GetStageData(stage).adv_logs
	var unordered_names = variable_struct_get_names(logs)
	var ordered_names = []
	for (var i = 0; i < array_length(unordered_names); ++i) {
		var ind = logs[$ unordered_names[i]].order
		ordered_names[ind] = unordered_names[i]
	}
	return ordered_names
}

function UnlockAdvLog(stage, name) {
	stage = MapStageName(room_get_name(stage))
	var stage_logs = stages_data[$ stage].adv_logs
	// update and save data
	if variable_struct_exists(stage_logs, name) {
		stage_logs[$ name].unlocked = true
		save.set("stages_data", stages_data)
		save.save()
		return
	}
	show_debug_message("Failed to find adv log {} in stage {}", name, stage)
}

function ResetProgress() {
	last_unlocked_stage = W1_1_part1
	stages_data = DefaultStagesData()
	save.set("last_unlocked_stage", last_unlocked_stage)
	save.set("stages_data", stages_data)
	save.save()
}

function UnlockedAdvLogsCount() {
	var res = 0
	var stage_names = variable_struct_get_names(stages_data)
	for (var i = 0; i < array_length(stage_names); ++i) {
	    var stage_logs = stages_data[$ stage_names[i]].adv_logs
		var log_names = variable_struct_get_names(stage_logs)
		for (var j = 0; j < array_length(stage_logs); ++j) {
			res += stage_logs[$ log_names[j]].unlocked	
		}
	}
	return res
}

function GetNotShowedAdventureLogs() {
	var res = []
	var stage_names = variable_struct_get_names(stages_data)
	for (var i = 0; i < array_length(stage_names); ++i) {
	    var stage_logs = stages_data[$ stage_names[i]].adv_logs
		var log_names = variable_struct_get_names(stage_logs)
		for (var j = 0; j < array_length(log_names); ++j) {
			var log_data = stage_logs[$ log_names[j]]
			if log_data.unlocked
					and !log_data.was_showed_in_adv_log_screen {
				array_push(res, log_names[j])
			}
		}
	}
	return res
}
