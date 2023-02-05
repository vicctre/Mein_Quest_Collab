
if state == PLAYERSTATE.ATTACK_AERAL {
	draw_sprite_ext(
		sprite_index, image_index, x, y, 1, 1,
		image_draw_angle, c_white, 1)
} else {
	draw_self()
}
