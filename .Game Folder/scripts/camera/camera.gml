
function camera_set_pos(x, y) {
    var cam = view_camera[0]
	camera_set_view_pos(cam,
						x-camera_get_view_width(cam)*0.5,
						y-camera_get_view_height(cam)*0.5)
}

function camw() {
	return camera_get_view_width(view_camera[0])
}

function camh() {
	return camera_get_view_height(view_camera[0])
}

function camx() {
	return camera_get_view_x(view_camera[0])
}

function camy() {
	return camera_get_view_y(view_camera[0])
}

function camx_cent() {
	return camera_get_view_x(view_camera[0]) + camw() * 0.5
}

function camy_cent() {
	return camera_get_view_y(view_camera[0]) + camh() * 0.5
}

function point_in_camera(xx, yy) {
	var cx = camx(), cy = camy()
	return (xx > cx) and (xx < (cx + camw()))
		   and (yy > cy) and (yy < (cy + camy()))
}
