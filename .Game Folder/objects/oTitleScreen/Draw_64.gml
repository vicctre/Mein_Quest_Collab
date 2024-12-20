


if DEV {
	debug_draw_var("win", $"{window_get_width()} - {window_get_height()}")
	debug_draw_var("view", $"{camera_get_view_width(view_camera[0])} - {camera_get_view_height(view_camera[0])}")
	debug_draw_var("appsurf", $"{surface_get_width(application_surface)} - {surface_get_height(application_surface)}")
	debug_draw_var("gui", $"{display_get_gui_width()} - {display_get_gui_height()}")
}


if !show_text
	exit

draw_set_font(fntMenu)
draw_set_halign(fa_center)
var c = c_white
draw_text_color(xx, yy, text, c, c, c, c, 1)

