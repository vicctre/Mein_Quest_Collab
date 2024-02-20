///remember, its locked to the screen not the camera 
/// @desc Draw menu 

var halign = draw_get_halign(), valign = draw_get_valign()

draw_set_font(fMenu)
draw_set_halign(fa_left)
draw_set_valign(fa_middle)

for (var i = 0; i < array_length(menu); i++) {
	var item = menu[i]
	var txt = item.title
	var col = c_grey
	if (menu_cursor == i) {
		col = c_white
	}
	var xx = menu_x
	var yy = menu_y + (menu_itemheight * (i * menu_item_distance_mult))
	if item.sprite {
		draw_sprite_ext(item.sprite, 0, xx, yy,
						icon_scale, icon_scale,
						0, c_white, 1)
		if !item.stage_locked {
			DrawAdvLogs(item.stage, xx, yy, adv_log_play_animation_index == i)
		}
	}
    // draw text in icon's left small window
	xx -= icon_half_width * 0.9
	DrawTextOutlined(txt, xx, yy, col)
}

draw_set_halign(halign)
draw_set_valign(valign)

draw_sprite_ext(sCursor, menu_cursor_frame, menu_cursor_x, menu_cursor_y,
				menu_cursor_scale, menu_cursor_scale, 0, c_white, 1)

