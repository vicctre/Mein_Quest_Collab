invincible = false
hit_blinking_timer = make_timer(10, false)
hit_blinking_gain = 180 / hit_blinking_timer.time
rotation = 0
dead_animation_fly_forward = false
dead_animation_fly_forward_speed = 0.025

function set_hit(damage=0) {
	if (!invincible) {
		hp -= damage
		if (object_index == oTuffull)
			audio_play_sound(SFX_Boss_Damage, 6, false)
        hit_blinking_timer.reset()

        //
		hit_direction = sign(x-global.player.x);
	}
    oEffects.emit_attack_contact(x, y)
    self._set_hit()
}

function _set_hit() {}

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
