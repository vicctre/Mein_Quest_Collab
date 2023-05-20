/// Set Up Camera

view_enabled = true
view_visible[0] = true
cam = view_camera[0]
follow = oPlayer
camera_set_view_size(cam, 512, 288)
view_w_half = camera_get_view_width(cam) * 0.5
view_h_half = camera_get_view_height(cam) * 0.5
xTo = x
yTo = y

shake_length = 60
shake_magnitude = 0
shake_remain= 0
buff = 32

