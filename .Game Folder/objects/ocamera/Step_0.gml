/// Update Camera
show_debug_message(cam_zoom_target);
//zoom areas
var area = noone;
with(global.player) {
	area = instance_place(x, y, oCameraZoomArea);
}
if (area != noone) {
	cam_zoom_area = area;
}
if (cam_zoom_area != noone) {
	if (area == noone)
		cam_zoom_target = 1;
	else
		cam_zoom_target = area.zoom_level;
}
//update zoom
if (cam_zoom_current != cam_zoom_target) {
	cam_zoom_current = lerp(cam_zoom_current, cam_zoom_target, 0.01);
	ResizeCamera();
}

//update destination aka where ever the player is 
if (instance_exists(follow)) 
{
	xTo = follow.x + x_shift;
	yTo = follow.y;
	
	if ((follow).object_index == oPlayerDead)
	{
		x = xTo; 
		y = yTo;
	}
}

// update object position
if smooth_movement_on {
	x += (xTo - x)/25; 
	y += (yTo - y)/25; 
} else {
	x = xTo;
	y = yTo;
}

x = clamp(x,view_w_half+buff,room_width-view_w_half-buff); 
y = clamp(y,view_h_half+buff,room_height-view_h_half-buff); 

//screen shake stuff
x_shake = random_range(-shake_remain,shake_remain); 
y_shake = random_range(-shake_remain,shake_remain); 
shake_remain = max(0,shake_remain - ((1/shake_length)*shake_magnitude)); 
if (shake_remain == 0) {
	x_shake = 0;
	y_shake = 0;
}

//Update Camera View 
camera_set_view_pos(cam,x-view_w_half + x_shake,y-view_h_half + y_shake); 


// bgr parallax
if layer_exists("BG1") {
	layer_x("BG1", (x + global.bgr1_xoffset) * global.bgr1_parallax)
	layer_y("BG1", (y + global.bgr1_yoffset) * global.bgr1_parallax)
}

if (layer_exists("BG2")) {
	layer_x("BG2", (x + global.bgr2_xoffset) * global.bgr2_parallax)
	layer_y("BG2", (y + global.bgr2_yoffset) * global.bgr2_parallax)
}

if (layer_exists("BG3")) {
	layer_x("BG3", (x + global.bgr3_xoffset) * global.bgr3_parallax)
	layer_y("BG3", (y + global.bgr3_yoffset) * global.bgr3_parallax)
}
