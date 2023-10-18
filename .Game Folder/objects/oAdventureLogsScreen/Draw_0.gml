
var x_ = scr_camx_cent(0);
var y_ = scr_camy_cent(0);

draw_sprite_ext(sAdvLog_BG, 0, x_, y_, 2, 2, 0, c_white, 1);

draw_sprite_ext(log_sprite, 0, x_, y_, log_scale, log_scale, 0, c_white, 1)

var description = "This 1'8\" tall creature has the unique ability to use his ears for practically anything, turning as strong as steel on command. Calling Eldoon his home, Mein travels to the Sister Temple to figure out what is going on with the peaceful planet";

draw_text_transformed(x_, y_-200, "Mein", 1, 1, 0);
//outline
draw_set_color(c_black);
draw_text_ext_transformed(x_+1, y_+65, description, 42, 580, 0.42, 0.42, 0);
draw_text_ext_transformed(x_-1, y_+65, description, 42, 580, 0.42, 0.42, 0);
draw_text_ext_transformed(x_, y_+1+65, description, 42, 580, 0.42, 0.42, 0);
draw_text_ext_transformed(x_, y_-1+65, description, 42, 580, 0.42, 0.42, 0);
draw_set_color(c_white);
//draw_set_color(#380c0c);

draw_text_ext_transformed(x_, y_+65, description, 42, 580, 0.42, 0.42, 0);
draw_set_color(c_white);
if goto_next_room_on {
	var c = c_white
	var yy = scr_camy_cent(0) + sprite_get_height(log_sprite) * log_scale * 0.5
	draw_text_color(scr_camx_cent(0), yy, "Press X to continue", c, c, c, c, 1)
}
