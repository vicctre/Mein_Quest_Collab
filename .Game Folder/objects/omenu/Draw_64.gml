///remember, its locked to the screen not the camera 
/// @desc Draw menu 

var halign = draw_get_halign(), valign = draw_get_valign()

draw_set_font(fMenu); 
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
//its important to set them BEFORE you draw any text 
for (var i = 0; i < array_length(menu); i++) //or "i = i + 1" we are just increasing it by 1 
{
	var offset = 2; 
	var txt = menu[i].title;
	if (menu_cursor == i)
	{
		//txt = Highlight(txt)
		var col = c_white;
	} else {
		var col = c_grey;
	}
	var xx = menu_x; 
	var yy = menu_y - (menu_itemheight * (i * 1.5));
	DrawTextOutlined(txt, xx, yy, col)
}

draw_set_halign(halign);
draw_set_valign(valign);

draw_sprite(sCursor, menu_cursor_frame, menu_cursor_x, menu_cursor_y);
