///remember, its locked to the screen not the camera 
/// @desc Draw menu 

draw_set_font(fMenu); 
draw_set_halign(fa_right); 
draw_set_valign(fa_bottom); 
//its important to set them BEFORE you draw any text 
for (var i = 0; i < array_length(menu); i++) //or "i = i + 1" we are just increasing it by 1 
{
	var offset = 2; 
	var txt = menu[i].title;
	if (menu_cursor == i) 
	{
		txt = string_insert("> ", txt,0); 
		var col = c_white; 
	}
	else
	{
		var col = c_grey; 
	}
	var xx = menu_x; 
	var yy = menu_y - (menu_itemheight * (i * 1.5)); 
	draw_set_color(c_black); //not the most efficient way to do this 
	draw_text(xx-offset,yy,txt); 
	draw_text(xx+offset,yy,txt); 
	draw_text(xx,yy-offset,txt); 
	draw_text(xx,yy+offset,txt); 
	draw_set_color(col); 
	draw_text(xx,yy,txt); 
}


