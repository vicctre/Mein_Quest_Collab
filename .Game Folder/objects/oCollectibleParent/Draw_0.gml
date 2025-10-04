if (flashing) {
	flash_timer = (flash_timer + 1) % flash_loop_duration;
	shader_set(WhiteShader);
	updateWhiteShader();
	draw_self();
	shader_reset();
} else
	draw_self();