// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function KillPlayer()
{
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
}