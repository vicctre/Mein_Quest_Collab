
event_inherited()

sound_effect = global.sfx_adventure_log

collected = function() {
	spawnHealFizzles()
	//audio_play_sound(sound_effect, 0, false)
	// launch collect log sequence
	instance_create_layer(0, 0, "Player", oSequencePickupLog)
	oStageManager.UnlockAdvLog(room, creature_name)
}
