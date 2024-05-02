
if is_sequence_finished() {
	oSequenceRulaAppear02.unpause()
	instance_destroy()
}

if DEV and oInput.key_attack {
	layer_sequence_speedscale(sequence_inst, 10)
}
