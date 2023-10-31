
if is_sequence_finished() {
	layer_sequence_speedscale(sequence_inst, 0)
	layer_sequence_headpos(sequence_inst, 0)
	if destroy_delay > 0 {
		alarm[0] = destroy_delay
	} else {
		instance_destroy()
	}
}
