if (flashing) {
	flash_timer = (flash_timer + 1) % flash_loop_duration;
	shader_set(WhiteShader);
	uniform = shader_get_uniform(WhiteShader, "white_alpha");
	shader_set_uniform_f(uniform, 2*abs(0.5-flash_timer/flash_loop_duration));
	draw_self();
	shader_reset();
} else
	draw_self();