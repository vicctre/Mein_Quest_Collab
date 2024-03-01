event_inherited();
image_angle -= apploon_rotation_speed;

if(place_meeting(x, y+1, WALLPARENT)) 
{
	if (deadSprite == -1)
		show_message("Error: this enemy's death sprite is not set");
	
	var inst = instance_create_layer(x,y,layer, deadEnemy);
	inst.flash = 0;
	inst.rotation_speed = apploon_rotation_speed*2;
	inst.sprite_index = deadSprite;
	inst.image_angle = image_angle;
	inst.image_xscale = image_xscale; 
	inst.hsp = 0;
	inst.vsp = -2;
	inst.image_yscale = size;
	instance_destroy(); 
}


