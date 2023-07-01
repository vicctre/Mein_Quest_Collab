
draw_set_alpha(alpha)
draw_set_color(global.configFog.color)
var xx = scr_camx(0), yy = scr_camy(0)
draw_rectangle(xx, yy, xx + scr_camw(0), yy + scr_camh(0), false)
draw_set_alpha(1)
draw_set_color(c_white)
