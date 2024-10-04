
// camera_set_view_size(cam, view_w, view_h)

view_set_wport(0, win_w)
view_set_hport(0, win_h)

var k = ratio
surface_resize(application_surface, cam_width * k, cam_height * k)
display_set_gui_size(gui_w, gui_h)
