
if global.rula_intro_cutscene_played or is_sequence_finished() {
    global.rula_intro_cutscene_played = true
	oSequenceRulaAppear02.unpause()
	instance_destroy()
}

if DEV and oInput.key_attack {
	layer_sequence_speedscale(sequence_inst, 10)
}
