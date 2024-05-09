/// Set Up Camera

function SetRoomStartCamera() {
	if room == W1_1_part1 or room == W1_1_part2 {
		oCamera.cam_zoom_current = 0.76
		oCamera.cam_zoom_target = 0.76
	}
}

view_enabled = true
view_visible[0] = true
cam = view_camera[0]
follow = global.player
cam_height = 288
cam_width = 512
cam_width_base = cam_width
cam_zoom_current = 1
cam_zoom_target = cam_zoom_current

cam_zoom_area = noone

ResizeCamera()
xTo = x
yTo = y
x_shift = 0

shake_length = 40
shake_magnitude = 1
shake_remain = 0
x_shake = 0
y_shake = 0
buff = 32

smooth_movement_on = true

function set_smooth_movement(turn_on) {
	smooth_movement_on = turn_on
}

function start_shaking(magnitude=1) {
	shake_remain = magnitude
}
