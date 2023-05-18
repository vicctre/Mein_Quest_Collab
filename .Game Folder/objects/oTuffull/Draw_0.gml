if (hp <= 5) {
	flash_timer = (flash_timer + 1) % flash_loop_duration;
	shader_set(RedShader);
	uniform = shader_get_uniform(RedShader, "red_alpha");
	shader_set_uniform_f(uniform, flash_percent_max*abs(0.5-flash_timer/flash_loop_duration));
	event_inherited();
	shader_reset();
} else
	event_inherited();
