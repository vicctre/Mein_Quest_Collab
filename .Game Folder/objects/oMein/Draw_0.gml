
if state == PLAYERSTATE.ATTACK_AERAL {
	draw_sprite_ext(
		sprite_index, image_index, x, y, 
		image_xscale, 1, image_draw_angle,
		c_white, 1)
} else {
	draw_self()
	if invincibility_timer.update() {
		draw_hit_blinking(hit_blinking_gain * invincibility_timer.timer)
	} else if heal_glowing_timer.update() {
		draw_hit_blinking(hit_blinking_gain * heal_glowing_timer.timer, global.heal_glowing_color)
    }
}

//draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true)
