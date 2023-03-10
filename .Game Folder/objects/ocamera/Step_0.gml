/// Update Camera

//update destination aka where ever the player is 
if (instance_exists(follow)) 
{
	xTo = follow.x; 
	yTo = follow.y; 
	
	if ((follow).object_index == oPlayerDead)
	{
		x = xTo; 
		y = yTo;
	}
}

//update object possiton 
x += (xTo - x)/25; 
y += (yTo - y)/25; 

x = clamp(x,view_w_half+buff,room_width-view_w_half-buff); 
y = clamp(y,view_h_half+buff,room_height-view_h_half-buff); 

//screen shake stuff
x += random_range(-shake_remain,shake_remain); 
y += random_range(-shake_remain,shake_remain); 
shake_remain = max(0,shake_remain - ((1/shake_length)*shake_magnitude)); 

//Update Camera View 
camera_set_view_pos(cam,x-view_w_half,y-view_h_half); 


// bgr parallax
if layer_exists("BG1") {
	var parallax = 0.5
	layer_x("BG1", (x + global.bgr1_xoffset) * parallax)
	layer_y("BG1", (y + global.bgr1_yoffset) * parallax)
}

if (layer_exists("BG2")) 
{
	var parallax = 0.7
	layer_x("BG2", (x + global.bgr2_xoffset) * parallax)
	layer_y("BG2", (y + global.bgr2_yoffset) * parallax)
}

if (layer_exists("BG3")) 
{
	var parallax = 0.9
	layer_x("BG3", (x + global.bgr3_xoffset) * parallax)
	layer_y("BG3", (y + global.bgr3_yoffset) * parallax)
}
