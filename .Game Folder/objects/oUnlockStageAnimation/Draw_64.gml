
draw_self()

if phase == 3 {
	gpu_set_fog(true, c_white, 0, 0)
	draw_sprite_ext(
		sprite_index,
		image_index,
		x, y,
		image_xscale, image_yscale,
		image_angle, c_white, white_alpha)
	gpu_set_fog(false, c_white, 0, 0)
}
