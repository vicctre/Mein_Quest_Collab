///remember, its locked to the screen not the camera 
/// @desc Draw menu 

var halign = draw_get_halign(), valign = draw_get_valign()

draw_set_font(fMenu); 
draw_set_halign(x_ancor);
draw_set_valign(y_ancor);
//its important to set them BEFORE you draw any text 
for (var i = 0; i < array_length(menu); i++) //or "i = i + 1" we are just increasing it by 1 
{
	var offset = 2; 
	var txt = menu[i].title;
	if (menu_cursor == i)
	{
		txt = Highlight(txt)
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

draw_set_halign(halign);
draw_set_valign(valign);
