timer = max(0, timer-1);

switch(boss_state) {
	case "Idle":
		hsp = 0;
		if (timer == 0) {
			if (charge_count > 0)
				changeState("Charge Prep");
			else
				changeState("Walk");
		}
	break;
	case "Charge Prep":
		if (timer == 0) {
			changeState("Charge");
		}
	break;
	case "Charge":
		hsp = lerp(hsp, hsp_target, 0.14);
		if (place_meeting(x+hsp, y, oWall)) {
			audio_play_sound(global.sfx_bonk, 5, false);
			oCamera.shake_remain = 1;
			changeState("Stunned");
		}
	break;
	case "Stunned":
		x = lerp(x, wallX-8*image_xscale, 0.08);
		if (timer == 0) {
			changeState("Idle");
		}
	break;
	case "Walk":
		if (timer == 0) {
			changeState("Jump Prep");
		}
	break;
	case "Jump Prep":
		if (timer == 0) {
			changeState("Jump");
		}
	break;
	case "Jump":
		if (vsp > 0) {
			changeState("Fall");
		}
	break;
	case "Fall":
		if (place_meeting(x,y+1,oWall)) {
			changeState("Idle");
		}
	break;
	case "Defeated":
		if (place_meeting(x,y+1,oWall)) {
			hsp *= 0.5;
		}
	break;
}

vsp = vsp + grv; 

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