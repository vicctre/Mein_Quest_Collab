
event_inherited();

sound_effect = global.sfx_adventure_log;

collected = function() {
	spawnHealFizzles();
	global.pages_placeholder = 1;
	audio_play_sound(sound_effect, 0, false);
}
