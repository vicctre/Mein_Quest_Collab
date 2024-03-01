function ResizeCamera(width = cam_width, height = cam_height, zoom = cam_zoom_current) {
	width *= zoom;
	height *= zoom;
	camera_set_view_size(cam, width, height);
	surface_resize(application_surface, width*16, height*16);
	display_set_gui_size(width*2, height*2)
	view_w_half = width / 2;
	view_h_half = height / 2;
}

function SnapCamera() {
	xTo = x;
	yTo = y;
	cam_zoom_current = cam_zoom_target;
	ResizeCamera();
}