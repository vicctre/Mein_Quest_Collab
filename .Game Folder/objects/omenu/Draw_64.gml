///remember, its locked to the screen not the camera 
/// @desc Draw menu 

var halign = draw_get_halign(), valign = draw_get_valign()

draw_set_font(fntMenu);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
for (var i = 0; i < array_length(menu); i++)
{
	var offset = 2; 
	var txt = menu[i].title;
	var col = non_highlight_color
	if (menu_cursor == i) {
		col = c_white;
	}
	var xx = menu_x; 
	var yy = menu_y + (menu_itemheight * (i * 1.5));
	DrawTextOutlined(txt, xx, yy, col)
}

draw_set_halign(halign);
draw_set_valign(valign);

DrawHintText()
draw_sprite_ext(sCursor, menu_cursor_frame, menu_cursor_x, menu_cursor_y,
				menu_cursor_scale, menu_cursor_scale, 0, c_white, 1);






