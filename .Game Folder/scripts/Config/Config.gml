/*
These are configs. There are different config value sets like Default and Dev.
You can change config in upper right corner of GM IDE.
Read more in manual.
*/

#macro DEV false
#macro DEMO false
#macro Dev:DEV true
#macro Demo:DEMO true

autoscroller_log_sp = 1.5
autoscroller_log_sp_increased = 4.15
///used to change autocroller log speed


death_transition_delay_time = 140
death_pause_time = 60

enemy_hit_blinking_color = #FFFF65

heal_coins_number = 100
heal_amount_large = 3
heal_amount_small = 1
heal_glowing_color = #A9F8BC // can set hex like #ff00ff

player_dead_vsp = -5
player_dead_hsp = 0
player_hp_max = 4
player_hp_max_overheal = 6
player_invincible = false
player_hp = player_hp_max
player_invincibilty_time = 90
player_door_enter_anim_sp = 0.65
player_damage_blinking_color = c_white
player_accel = 0.2
player_decel = 0.5
player_pogo_just_unlocked = true // show pop up message
// knockback speed on being hit
// and knockback state time
player_hit_state = {
	vsp: -5, //vertical knockback (was 4.0) 
	hsp:2.5, //horizontal knockback (was 4.0)
	time: 20,
	timer: 0
}


spirit_byte_flickering_image_speed = 0.5

tufful_hp = 14
tufful_intro_landing_time = 117
tuffull_intro_roar_time = 178

voleyball = false

// fog effect for parallax backgrounds
// you can override this setting for each level
// in oFogController RoomStart event
configFog = {
	alpha1: 0.1,
	alpha2: 0.15,
	alpha3: 0.15,
	color: #94C8F2,
}

if DEV {
	//player_hp_max = 4
	//player_hp = player_hp_max
	//player_invincible = true
	//tufful_hp = 1
	audio_set_master_gain(0, 0.1)
}
