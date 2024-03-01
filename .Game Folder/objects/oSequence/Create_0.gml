
sequence = noone
sequence_inst = noone
destroy_delay = 10

function is_sequence_finished() {
	var sp = layer_sequence_get_speedscale(sequence_inst)
	return layer_sequence_get_headpos(sequence_inst)
		   >= (layer_sequence_get_length(sequence_inst) - sp)
}

function is_sequence_on_frame(frame) {
	return layer_sequence_get_headpos(sequence_inst) == frame
}

function is_playing() {
	return layer_sequence_get_speedscale(sequence_inst) != 0
}

function pause() {
	layer_sequence_speedscale(sequence_inst, 0)
}

function unpause() {
	layer_sequence_speedscale(sequence_inst, 1)
}

function on_destroy() {
	
}

function notify_started() {
	oEventSystem.Notify(Events.cutscene_start)
}

function notify_ended() {
	oEventSystem.Notify(Events.cutscene_end)
}
