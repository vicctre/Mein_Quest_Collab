

draw_sprite_ext(log_sprite, 0, scr_camx_cent(0), scr_camy_cent(0),
				log_scale, log_scale, 0, c_white, 1)

if goto_next_room_on {
	var c = c_white
	var yy = scr_camy_cent(0) + sprite_get_height(log_sprite) * log_scale * 0.5
	draw_text_color(scr_camx_cent(0), yy, "Press X to continue", c, c, c, c, 1)
}
