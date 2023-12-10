event_inherited()

sequence = seqLogAutoscrollerStart
sequence_inst = layer_sequence_create(layer, x, y, sequence)
destroy_delay = 10
visible = false

function on_destroy() {
	SlideTransition(TRANS_MODE.GOTO, W1_2_part4_AutoScroller1)
}

// will be unpaused by player closing in
pause()
