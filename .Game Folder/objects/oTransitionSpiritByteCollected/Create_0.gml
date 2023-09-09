
event_inherited()

next_room = W1_2_part1
destroy_delay = 60
sequence = seqPlayerVictory

transition_timer = 7 * 60

phase = 0

function is_transition_finished() {
	return !transition_timer
}
