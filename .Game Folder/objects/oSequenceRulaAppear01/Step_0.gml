
if is_sequence_finished() or global.rula_intro_cutscene_played {
    global.rula_intro_cutscene_played = true
	instance_destroy()
}

if DEV and oInput.key_attack {
	layer_sequence_speedscale(sequence_inst, 10)
}
