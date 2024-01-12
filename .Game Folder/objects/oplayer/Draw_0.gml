
if state == PLAYERSTATE.ATTACK_AERAL {
	draw_sprite_ext(
		sprite_index, image_index, x, y, 
		image_xscale, 1, image_draw_angle,
		c_white, 1)
} else {
	draw_self()
	if invincibility_timer-- {
		draw_invincibility_blinking()
	}
}

//draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true)
