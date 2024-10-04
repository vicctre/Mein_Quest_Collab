
camera_set_view_size(view_camera[0], view_w, view_h)

view_set_wport(0, win_w)
view_set_hport(0, win_h)

var k = 1
surface_resize(application_surface, view_w * k, view_h * k)
