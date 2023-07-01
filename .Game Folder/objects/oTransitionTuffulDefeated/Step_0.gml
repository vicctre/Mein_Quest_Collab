
if sequence_inst == noone {
	if !oPlayer.down_free {
		sequence_inst = layer_sequence_create(
				layer, oPlayer.x, oPlayer.y, sequence)
	}
} else {
	if is_transition_finished() {
		SlideTransition(TRANS_MODE.GOTO, next_room)
		layer_sequence_speedscale(sequence_inst, 0)
		alarm[0] = destroy_delay
	}
}
