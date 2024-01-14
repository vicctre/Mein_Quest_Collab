//this is where we would impliment zooming 
//make sure you do that before you position 
#macro view view_camera[0]
camera_set_view_size(view,view_width,view_height); 


//center the view on the player 
if (instance_exists(oMein)) 
{
	var _x = clamp(oMein.x-view_width/2,0,room_width-view_width); 
	var _y = clamp(oMein.y-view_width/2,0,room_height-view_width);
	
 var _cur_x = camera_get_view_x(view); 
 var _cur_y = camera_get_view_y(view); 
 
 var _spd = .1; //the higher this number the faster the cam will move 
 camera_set_view_pos(view,lerp(_cur_x, _x, _spd),lerp(_cur_y, _y, _spd)); 
						 
}

//the example game used was a top down perspective, not sure if everything applies for 2D platformer 


