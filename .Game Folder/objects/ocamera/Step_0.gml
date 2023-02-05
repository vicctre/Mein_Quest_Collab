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

if (layer_exists("BG2")) 
{
	layer_x("BG2",x/2); 
}

if (layer_exists("BG3")) 
{
	layer_x("BG3", x - view_w_half);
}

if (layer_exists("BG1"))
{
	layer_x("BG1",x/4)
}
