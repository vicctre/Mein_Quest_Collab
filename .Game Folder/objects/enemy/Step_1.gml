if(hp <= 0) 
{
	
	with(instance_create_layer(x,y,layer,oEnemy01Ded)) 
	{
		image_xscale = other.test; 
		hsp = image_xscale*lengthdir_x(3,direction); 
		vsp = lengthdir_y(3,direction)-3;
		image_yscale = other.size;
	}
	
	instance_destroy(); 
}


