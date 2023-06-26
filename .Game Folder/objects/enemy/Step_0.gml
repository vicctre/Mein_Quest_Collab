var dir = sign(oPlayer.x-x);
if (!attacking && walksp == 0)
	image_xscale = dir;

if (!flying)
	vsp = vsp + grv;

//dont walk off edges 
if (grounded) && (afraidofheights) && (!collision_point(x + abs(bbox_right-x) * image_xscale, bbox_bottom+1, oWall, false, true) && !flying) 
{
	hsp = -hsp; 
}
if (flying && abs(baseX-x) > leashRange) {
	hsp_goal = abs(hsp_goal)*sign(baseX-x);
}
//Collision (horizontal) 
if (place_meeting(x+hsp,y,oWall))
{
	while (!place_meeting(x+sign(hsp),y,oWall))
	{
		x = x + sign(hsp); 
	}
	if (flying)
		hsp = 0;
	else
		hsp = -hsp;
	hsp_goal = -hsp_goal;
}
if (flying)
	hsp = lerp(hsp, hsp_goal, 0.04);
x = x + hsp; 

if (flying && abs(baseY-y) > leashRange) {
	vsp_goal = abs(vsp_goal)*sign(baseY-y);
}
//Collision (vertical) 
if (place_meeting(x,y+vsp,oWall))
{
	while (!place_meeting(x,y+sign(vsp),oWall))
	{
		y = y + sign(vsp);
	}
	if (flying) {
		vsp = -vsp;
		vsp_goal = -vsp_goal;
	} else
		vsp = 0;
}
if (flying)
	vsp = lerp(vsp, vsp_goal, 0.04);
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
