vsp = vsp + grv; 

//dont walk off edges 
if (grounded) && (afraidofheights) && (!place_meeting(x+hsp,y+1,oWall)) 
{
	
	hsp = -hsp; 
}

//Collision (horizontal) 
if (place_meeting(x+hsp,y,oWall))
{
	while (!place_meeting(x+sign(hsp),y,oWall))
	{
		x = x + sign(hsp); 
	}
	hsp = -hsp; 
}
x = x + hsp; 

//Collision (vertical) 
if (place_meeting(x,y+vsp,oWall))
{
	while (!place_meeting(x,y+sign(vsp),oWall))
	{
		y = y + sign(vsp); 
	}
	vsp = 0; 
}
y = y + vsp; 

//Animations 

if (!place_meeting(x,y+1,oWall)) 
{
	grounded = false; 

}
else 
{
	grounded = true; 


}

if (hsp != 0) image_xscale = sign(hsp) * size; 
image_yscale = size; 




