invincible = false;

function set_hit(damage=0) {
	if (!invincible) {
		hp -= damage
		flash = 6;
		if (object_index == oTuffull)
			audio_play_sound(SFX_Boss_Damage, 6, false);
		if (hp > 0) {
			state = ENEMYSTATE.HIT 
			hitNow = true
		} else {
			state = ENEMYSTATE.DEAD
		}
	
		//
		hit_direction = sign(x-global.player.x);
	}
}

function draw_hit_flashing() {
	if (flash > 0) {
		flash--; 
		shader_set(SHWhite);
		draw_self(); 
		shader_reset(); 
	} else {
		draw_self();
	}
}

hp_max = 1
hp = hp_max
