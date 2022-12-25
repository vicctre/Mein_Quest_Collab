if(hp <= 0) 
{
	with(instance_create_layer(x,y,layer,oDed2)) 
	{
		direction = other.hitfrom; 
		hsp = lengthdir_x(3,direction); 
		vsp = lengthdir_y(3,direction)-3;
		if (sign(hsp) = 0) image_xscale = sign(hsp) * other.size;
		image_yscale = other.size;
	}
	
	instance_destroy(); 
}




