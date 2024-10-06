
// camera_set_view_size(cam, view_w, view_h)

view_set_wport(0, win_w)
view_set_hport(0, win_h)

try {
	surface_resize(application_surface, cam_width, cam_height)
} catch (err) {
	show_debug_message($"Error on resizing application_surface\n\n{err.longMessage}")
	alarm[1] = 30
}
display_set_gui_size(gui_w, gui_h)
