
var xx = scr_camx(0)
var yy = scr_camy(0)

draw_set_alpha(dim_alpha)
draw_set_color(c_black)
draw_rectangle(xx, yy, xx + scr_camw(0), yy + scr_camh(0), false)
draw_set_alpha(1)
draw_set_color(c_white)
