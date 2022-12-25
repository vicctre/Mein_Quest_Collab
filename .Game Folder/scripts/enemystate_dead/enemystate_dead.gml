// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EnemyState_Dead()
{
vsp = vsp + grv; 


	//Horizontal Collision 
if (place_meeting(x+hsp,y,oWall))
{
	while (!place_meeting(x+sign(hsp),y,oWall))
	{
		x = x + sign(hsp); 
	}
hsp = 0; 
}
x = x + hsp; 

//Vertical Collision 
if (place_meeting(x,y+vsp,oWall))
{
	if (vsp = 0) 
{
	done = 1; 
}
	while (!place_meeting(x,y+sign(vsp),oWall))
	{
		y = y + sign(vsp); 
	}
	vsp = 0; 
}
y = y + vsp; 


}