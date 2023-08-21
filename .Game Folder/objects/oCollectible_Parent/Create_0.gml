vspd = -3;
grav = 0.3;
activated = true;
activation_delay = 30;
flashing = object_index != oCoin;
flash_timer = 0;
flash_loop_duration = 100;
sound_effect = noone;

function updateWhiteShader() {
	uniform = shader_get_uniform(WhiteShader, "white_alpha");
	shader_set_uniform_f(uniform, 1.8*power(abs(0.5-flash_timer/flash_loop_duration),2));
}
updateWhiteShader();

collected = function() {
	spawnHealFizzles();
	if sound_effect != noone {
		audio_play_sound(sound_effect, 0, false)	
	}
}