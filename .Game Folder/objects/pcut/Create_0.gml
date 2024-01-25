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
		hitDirection = sign(x-global.player.x);
	}
}

hp_max = 1
hp = hp_max
