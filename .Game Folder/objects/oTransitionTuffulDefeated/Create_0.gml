
sequence = noone
next_room = W1_2_part1
destroy_delay = 120

function is_transition_finished() {
	return layer_sequence_get_headpos(sequence)
		   == (layer_sequence_get_length(sequence) - 1)
}
