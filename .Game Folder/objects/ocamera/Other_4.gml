if (room == MenuTitleScreenV1)
	exit;
if (room == W1_1_part4) {
	x = 240
	y = 200
	cam_zoom_target = 0.8;
	SnapCamera();
	follow = id;
	cam_width = 480;
} else {
	cam_zoom_current = 0.76;
	cam_zoom_target = 0.76;
	ResizeCamera()
	follow = oPlayer
	cam_width = cam_width_base;
}