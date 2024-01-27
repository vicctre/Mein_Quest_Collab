
event_inherited()
sequence = seqOpeningIntro
sequence_inst = layer_sequence_create(layer, x, y, sequence)
destroy_delay = 0

if DEV {
	layer_sequence_headpos(sequence_inst, layer_sequence_get_length(sequence_inst) - 300)
}

function on_destroy() {
	room_goto_next()
}
