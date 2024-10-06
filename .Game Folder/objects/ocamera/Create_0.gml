/// Set Up Camera

function SetRoomStartCamera() {
	if room == W1_1_part1 or room == W1_1_part2 {
		oCamera.cam_zoom_current = .76
		oCamera.cam_zoom_target = .76
	}
}

gui_w = 1366
gui_h = 768

win_w = window_get_width()
win_h = window_get_height()

view_enabled = true
view_visible[0] = true
cam = view_camera[0]
follow = global.player
cam_height = 288 //768 //360
cam_width = 512 //1366 //640
cam_width_base = cam_width
cam_zoom_current = 1
cam_zoom_target = cam_zoom_current
ratio = 1

//// Keep camera size from room editor
if array_contains([
    rmIntroSequence,
    rmTitleScreen,
    rmMainMenu,
    rmMenuAdventureLogsScreen,
    rmThanksForPlayingScreen,
    rmAdventureLogsScreen,
    rmStartingCutscene,],
    room
) {
    cam_width = camera_get_view_width(cam)
    cam_height = camera_get_view_height(cam)
}


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
smooth_factor_default = 0.1
smooth_factor = smooth_factor_default

function set_smooth_movement(turn_on) {
	smooth_movement_on = turn_on
}

function start_shaking(magnitude=1) {
	shake_remain = magnitude
}

function set_target(inst) {
	follow = inst
}

function set_point_target(xx, yy) {
	follow = new Vec2(xx, yy)
}

function reset_smooth_factor() {
	smooth_factor = smooth_factor_default
}

function set_smooth_factor(factor) {
	smooth_factor = factor
}

function adjust_view_size() {
	win_w = window_get_width()
	win_h = window_get_height()

	ratio = win_w / cam_width
	if (win_w mod cam_width) != 0 {
	    var lower_ratio = floor(ratio)
	    var higher_ratio = ceil(ratio)
	    ratio = abs(ratio - lower_ratio) 
	                < abs(ratio - higher_ratio) 
	            ? lower_ratio
	            : higher_ratio
	}
	cam_width = win_w / ratio
	cam_height = win_h / ratio
    cam_width_base = cam_width
	alarm[1] = 3
}

adjust_view_size()
