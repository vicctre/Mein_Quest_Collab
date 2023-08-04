event_inherited();
deadSprite = sTuffull_HitWall;
hp = global.tufful_hp; //set this back to 20 when ur done testing
spd_walk = 3;
spd_charge = 5.6;
spd_jump = 3;
jump_height = 8;
timer = 80;
image_xscale = -size;
hsp_target = 0; //speed to accelerate hsp towards

idle_time = 30;
charge_prep_time = 50;
stun_time = 50;
walk_time = 40;
jump_prep_time = 20;
charge_count = 3;

flash_timer = 0;
flash_loop_duration = 40 //how many steps a full loop takes
flash_percent_max = 0.35; //0 = no flash, 1 = fully red

// play sequence first
boss_state = "__wait_sequence__";
visible = false
hsp = 0
instance_create_layer(x, y, layer, oSequenceTuffulAppear)

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
			audio_play_sound(SFX_Boss_Dash, 5, false);
			hsp_target = image_xscale*spd_charge;
			sprite_index = sTuffull_charge;
		break;
		case "Stunned":
			wallX = x;
			hsp = 0;
			hsp_target = 0;
			timer = stun_time;
			sprite_index = sTuffull_HitWall;
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
			audio_play_sound(SFX_Boss_jump, 5, false);
			hsp = spd_jump;
			vsp = -jump_height;
			sprite_index = sTuffull_jump;
		break; 
		case "Fall":
			charge_count = 3;
			sprite_index = sTuffull_jump_fall;
		break;
		case "Defeated":
			sprite_index = sTuffull_HitWall;
			image_xscale = -hitDirection; 
			hsp = hitDirection*2;
			vsp = -5;
			StartTuffulDefeatedTransition()
		break;
	}
}