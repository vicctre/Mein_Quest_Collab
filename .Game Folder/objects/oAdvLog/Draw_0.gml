
draw_self()

draw_text_outlined(x, y + name_rel_y, name, c_white, c_black)

//outline
draw_set_halign(fa_center)
draw_set_valign(fa_top)
var scale = 0.7
draw_set_color(c_black)
draw_text_ext_transformed(x+1, y+text_rel_y, text, 42, 580, scale, scale, 0)
draw_text_ext_transformed(x-1, y+text_rel_y, text, 42, 580, scale, scale, 0)
draw_text_ext_transformed(x, y+1+text_rel_y, text, 42, 580, scale, scale, 0)
draw_text_ext_transformed(x, y-1+text_rel_y, text, 42, 580, scale, scale, 0)
draw_set_color(c_white)

draw_text_ext_transformed(x, y+text_rel_y, text, 42, 580, scale, scale, 0)
draw_set_color(c_white)

