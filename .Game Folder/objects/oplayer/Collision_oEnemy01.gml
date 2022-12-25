/// @desc taking damage or dead
instance_change(oPlayerDamage,true); 
direction = point_direction(other.x,other.y,x,y); 
hsp = lengthdir_x(0,direction); 
vsp = lengthdir_y(5,direction) -2; 

if (sign(hsp) !=0) image_xscale = sign(hsp); 


instance_change(oPlayerDead,true); 
direction = point_direction(other.x,other.y,x,y); 
hsp = lengthdir_x(0,direction); 
vsp = lengthdir_y(5,direction) -2; 

if (sign(hsp) !=0) image_xscale = sign(hsp); 
