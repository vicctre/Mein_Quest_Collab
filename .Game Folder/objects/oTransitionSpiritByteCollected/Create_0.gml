
event_inherited()

var next_level_room = DEMO ? rmThanksForPlayingScreen : W1_2_part1

next_room = current_log_count() 
			? rmAdventureLogsScreen : next_level_room

destroy_delay = 60
sequence = choose(seqPlayerVictory, seqPlayerVictory02);

transition_timer = 7 * 60
transition_timer_on = true

phase = 0

function is_transition_finished() {
	return !transition_timer
}

function pause() {
	layer_sequence_speedscale(sequence_inst, 0)
	transition_timer_on = false
}

function unpause() {
	layer_sequence_speedscale(sequence_inst, 1)
	transition_timer_on = true
}
