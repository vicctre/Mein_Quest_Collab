
if DEV {
	debug_draw_var("win", $"{window_get_width()} - {window_get_height()}")
	debug_draw_var("view", $"{camera_get_view_width(cam)} - {camera_get_view_height(cam)}")
	debug_draw_var("appsurf", $"{surface_get_width(application_surface)} - {surface_get_height(application_surface)}")
	debug_draw_var("gui", $"{display_get_gui_width()} - {display_get_gui_height()}")
}
