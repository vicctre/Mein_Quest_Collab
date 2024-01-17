/// idk Spalding said better turn blend off
gpu_set_blendenable(false)

var ww = window_get_width()
var sw = surface_get_width(application_surface)
var scale = window_get_width() / surface_get_width(application_surface)
draw_surface_ext(application_surface,
				 0 - frac(x) / scale,
				 0 - frac(y) / scale,
				 scale, scale, 0, c_white, 1)


gpu_set_blendenable(true)
