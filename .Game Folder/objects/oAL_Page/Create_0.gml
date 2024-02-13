
event_inherited();

sound_effect = global.sfx_adventure_log;

collected = function() {
	spawnHealFizzles();
	global.current_logs[id_number] = true;
	//audio_play_sound(sound_effect, 0, false);
	// launch collect log sequence
	instance_create_layer(0, 0, "Player", oSequencePickupLog)
}
