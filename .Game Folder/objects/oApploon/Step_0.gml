event_inherited();
rotation -= apploon_rotation_speed;

if(place_meeting(x, y+1, oWallParent)) 
{
	if (deadSprite == -1)
		show_message("Error: this enemy's death sprite is not set");
	
	var inst = instance_create_layer(x,y,layer, oDeadEnemy);
	inst.hit_blinking_gain = 0;
	inst.hit_blinking_timer = hit_blinking_timer
	inst.rotation_speed = apploon_rotation_speed*2;
	inst.sprite_index = deadSprite;
	inst.image_angle = image_angle;
	inst.image_xscale = image_xscale; 
	inst.hsp = 0;
	inst.vsp = -2;
	inst.image_yscale = size;
	instance_destroy(); 
}


