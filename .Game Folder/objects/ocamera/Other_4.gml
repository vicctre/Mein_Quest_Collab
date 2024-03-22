if (room == rmTitleScreen)
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
} else if (room == W1_2_part2) {
	cam_zoom_target = 0.8125;
	SnapCamera();
} else {
	SetRoomStartCamera()
	ResizeCamera()
	follow = global.player
	cam_width = cam_width_base;
}