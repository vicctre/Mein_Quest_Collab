event_inherited();
deadSprite = sTuffull_HitWall_dead;
hp = 10;
spd_walk = 2;
spd_charge = 5;
spd_jump = 3;
jump_height = 8;
boss_state = "Idle";
timer = 100;
image_xscale = -size;

idle_time = 30;
charge_prep_time = 70;
stun_time = 60;
walk_time = 10;
jump_prep_time = 50;
charge_count = 3;

changeState = function(newState) {
	if (boss_state == newState)
		return false;
	boss_state = newState;
	switch(newState) {
		case "Idle":
			timer = idle_time;
			image_xscale *= -1;
			sprite_index = sTuffull_Idle;
		break;
		case "Charge Prep":
			charge_count = max(0, charge_count-1);
			timer = charge_prep_time;
			sprite_index = sTuffull_charge_prep;
		break;
		case "Charge":
			hsp = image_xscale*spd_charge;
			sprite_index = sTuffull_charge;
		break;
		case "Stunned":
			wallX = x;
			hsp = 0;
			timer = stun_time;
			sprite_index = sTuffull_HitWall_dead;
		break;
		case "Walk":
			timer = walk_time;
			hsp = image_xscale*spd_walk;
			sprite_index = sTuffull_walking;
		break;
		case "Jump Prep":
			hsp = 0;
			timer = jump_prep_time;
			sprite_index = sTuffull_jump_prep;
		break;
		case "Jump":
			hsp = spd_jump;
			vsp = -jump_height;
			sprite_index = sTuffull_jump;
		break; 
		case "Fall":
			charge_count = 3;
			sprite_index = sTuffull_jump_fall;
		break;
		case "Defeated":
			sprite_index = sTuffull_HitWall_dead;
			image_xscale = -hitDirection; 
			hsp = hitDirection*2;
			vsp = -5;
		break;
	}
}