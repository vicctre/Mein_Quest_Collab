if (room == MenuTitleScreenV1)
	exit;
	
if (room = rmAdventureLogsScreen) {
	x = 1376
	y = 768 
}
if (room == W1_1_part5) {
	x = 240
	y = 200
	cam_zoom_target = 0.8;
	SnapCamera();
	follow = id;
	cam_width = 480;
} else {
	SetRoomStartCamera()
	ResizeCamera()
	follow = oPlayer
	cam_width = cam_width_base;
}