
event_inherited()

global.player = id

hsp = global.autoscroller_log_sp_increased
vsp = 0
min_float_up_vsp = -0.1 //used to adjust float when landing in water?
jump_sp = -7
bottom_bound_y = y
has_control = true
grav = 0.3
jump_timer = 0
is_floating = true
was_floating = true
was_down_free = true

death_delay = 45
death_delay_timer = -1

wall_obj = oWall

function Kill() {
	if _is_dead {
		return;	
	}
	_is_dead = true
	global.player_hp = 0
	sprite_index = sPlayerDead
	has_control = false
	hsp = 0
	//y -= 30
	//visible = false
	oMusic.switch_music(noone, false, 0)
	oUI.shake_hp()
	// death_delay_timer = death_delay
	alarm[1] = global.death_transition_delay_time
	create_death_animation()
	visible = false
	death_animation_started = true
	// workaround: death music will player after unpause
	alarm[2] = 1
	oPause.PauseWithTimer(global.death_pause_time)
}

function Hit() {
	if invincibility_timer or invincibility_timer_no_flashing {
		return
	}
	global.player_hp -= global.player_invincible == false
	show_debug_message("Hit")
	audio_play_sound(global.sfx_player_damage, 8, false)
	// this is for when we have both a voice AND SFX for taking damage 
	if !global.player_hp {
		Kill()
		return
	}
	invincibility_timer = invincibility_time
	oUI.shake_hp()
}

_is_dead = false
function is_dead() {
	return _is_dead
}

var cam = instance_create_layer(x, y, layer, oCamera)
cam.x_shift = 150
