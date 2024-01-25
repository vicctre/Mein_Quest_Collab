///remember, its locked to the screen not the camera 
/// @desc Draw menu 

// scroll debugging
//var yy = menu_cursor_y_min
//draw_line(0, yy, 10000, yy)
//var yy = menu_cursor_y_max
//draw_line(0, yy, 10000, yy)

var halign = draw_get_halign(), valign = draw_get_valign()

draw_set_font(fMenu)
draw_set_halign(fa_left)
draw_set_valign(fa_bottom)

for (var i = 0; i < array_length(menu); i++) {
	var txt = menu[i].title
	var col = c_grey
	if (menu_cursor == i) {
		var col = c_white
	}
	var xx = menu_x
	var yy = menu_y + (menu_itemheight * (i * 1.5))
	if menu[i].sprite {
		draw_sprite_ext(menu[i].sprite, 0, xx, yy + menu_cursor_y_shift,
						icon_scale, icon_scale,
						0, c_white, 1)
	}
	xx -= spr_half_width * 0.9
	DrawTextOutlined(txt, xx, yy, col)
}

draw_set_halign(halign)
draw_set_valign(valign)

draw_sprite(sCursor, menu_cursor_frame, menu_cursor_x, menu_cursor_y)
