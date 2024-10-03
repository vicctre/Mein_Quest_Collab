enum SpiritByteSequence {
    move_mein_to_position,
    start_sequence,
    end_sequence,
    finish_stage,
}
event_inherited()

var next_level_room = W1_2_part1

var is_new_adv_logs_collected 
	= array_length(oStageManager.GetNotShowedAdventureLogs()) != 0
//next_room = is_new_adv_logs_collected ? rmAdventureLogsScreen : next_level_room
next_room = rmAdventureLogsScreen

destroy_delay = 60
//this is where you can add sequences you make at any time. It will choose from these options 
sequence = choose(seqPlayerVictory, seqPlayerVictory02, seqPlayerVictory03, seqPlayerVictory04);

// workaround transition becoming invisible for a couple frames
start_from_frame = undefined

transition_end_timer = make_timer(60)

phase = 0

function pause() {
	layer_sequence_speedscale(sequence_inst, 0)
}

function unpause() {
	layer_sequence_speedscale(sequence_inst, 1)
}

victory_music = global.msc_stage_clear
switch room {
    case W1_3BOSS:
        victory_music = BGM_BossCLEAR01
    break
}
