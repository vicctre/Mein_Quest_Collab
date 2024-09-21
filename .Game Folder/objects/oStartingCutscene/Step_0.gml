
if is_sequence_finished() {
    sequence_ind++
    if sequence_ind >= array_length(sequences) {
        layer_sequence_speedscale(sequence_inst, 0)
        layer_sequence_headpos(sequence_inst, 0)
        if destroy_delay > 0 {
            alarm[0] = destroy_delay
        } else {
            instance_destroy()
        }
    } else {
        layer_sequence_destroy(sequence_inst)
        sequence_inst = layer_sequence_create(layer, x, y, sequences[sequence_ind])
    }
}

if oInput.key_action {
	RoomTransition(TRANS_MODE.NEXT);
}
