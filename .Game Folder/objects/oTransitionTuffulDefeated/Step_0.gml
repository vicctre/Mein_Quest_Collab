
if sequence == noone and !oPlayer.down_free {
	sequence = layer_sequence_create(
			layer, oPlayer.x, oPlayer.y, seqPlayerVictory)
} else {
	if is_transition_finished() {
		SlideTransition(TRANS_MODE.GOTO, next_room)
		layer_sequence_speedscale(sequence, 0)
		alarm[0] = destroy_delay
	}
}
