
sequence = noone
sequence_inst = noone
destroy_delay = 60

function is_transition_finished() {
	return layer_sequence_get_headpos(sequence_inst)
		   == (layer_sequence_get_length(sequence_inst) - 1)
}
