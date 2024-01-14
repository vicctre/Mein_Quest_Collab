
global.player = id

hsp = global.autoscroller_log_sp_increased
vsp = 0
min_float_up_vsp = -1
jump_sp = -7
bottom_bound_y = y
has_control = true
grav = 0.3
jump_timer = 0

wall_obj = oWall

function Kill() {
	//global.player_hp = 0
	//sprite_index = sPlayerDead
	//state = PLAYERSTATE.PRE_DEAD
	//has_control = false
	//hsp = 0
	////y -= 30
	////visible = false
	//oMusic.switch_music(noone, false, 0)
	//oPause.PauseWithTimer(global.death_pause_time)
	//oUI.shake_hp()
}

function Hit() {
	//if invincibility_timer {
	//	return
	//}
	//global.player_hp -= global.player_invincible == false
	//show_debug_message("Hit")
	//audio_play_sound(global.sfx_player_damage, 8, false)
	////this is for when we have both a voice AND SFX for taking damage 
	//if !global.player_hp {
	//	Kill()
	//	return
	//}
	//vsp = hit.vsp
	//hsp = hit.hsp * -image_xscale
	//has_control = false
	//hit.timer = hit.time
	//state = PLAYERSTATE.HIT
	//sprite_index = sPlayerDamage
	//invincibility_timer = invincibility_time
	//oUI.shake_hp()
}

instance_create_layer(x, y, layer, oCamera)
