
event_inherited()

next_room = rmAdventureLogsScreen
destroy_delay = 60
sequence = seqPlayerVictory

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
