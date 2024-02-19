
draw_self()

draw_text_outlined(x, y - 200, name, c_white, c_black)

//outline
draw_set_halign(fa_center)
draw_set_valign(fa_top)
var scale = 0.7
var dy = 30
draw_set_color(c_black)
draw_text_ext_transformed(x+1, y+dy, text, 42, 580, scale, scale, 0)
draw_text_ext_transformed(x-1, y+dy, text, 42, 580, scale, scale, 0)
draw_text_ext_transformed(x, y+1+dy, text, 42, 580, scale, scale, 0)
draw_text_ext_transformed(x, y-1+dy, text, 42, 580, scale, scale, 0)
draw_set_color(c_white)
//draw_set_color(#380c0c)

draw_text_ext_transformed(x, y+dy, text, 42, 580, scale, scale, 0)
draw_set_color(c_white)

