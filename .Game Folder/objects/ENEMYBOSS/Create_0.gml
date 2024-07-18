
event_inherited()
hp_ui = instance_create_layer(0, 0, layer, oBossHpUI)
hp_ui.target = id
hit_direction = 0

flash_timer = 0;
flash_loop_duration = 40 //how many steps a full loop takes
flash_percent_max = 0.35; //0 = no flash, 1 = fully red
flash_hp_amount = 5

function set_hit(damage=0) {
	hp -= damage
    hit_blinking_timer.reset()
	audio_play_sound(SFX_Boss_Damage, 6, false);
	hit_direction = sign(x-global.player.x);
    oEffects.emit_attack_contact(x, y)
}

function drawRedFlashingOnLowHp() {
	if (hp > 0 && hp <= flash_hp_amount) {
		flash_timer = (flash_timer + 1) % flash_loop_duration
		shader_set(RedShader)
		var alpha = flash_percent_max*abs(0.5-flash_timer/flash_loop_duration)
		uniform = shader_get_uniform(RedShader, "red_alpha")
		shader_set_uniform_f(uniform, alpha)
		event_inherited()
		shader_reset()
	} else
		event_inherited()
}

// override this in child object
function isDead() {
	throw "Boss's isDead() function is not implemented!"
}
