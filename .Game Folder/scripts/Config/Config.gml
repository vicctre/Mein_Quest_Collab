
#macro DEV false
#macro DEMO false
#macro Dev:DEV true
#macro Demo:DEMO true

death_transition_delay_time = 140
death_pause_time = 60

heal_amount_large = 3
heal_amount_small = 1

player_dead_vsp = -5
player_dead_hsp = 0
player_hp_max = 4
player_invincible = false
player_hp_start = player_hp_max
player_hp = player_hp_start
player_invincibilty_time = 90
player_door_enter_anim_sp = 0.65
player_damage_blinking_color = c_white
player_accel = 0.2
player_decel = 0.5

spirit_byte_flickering_image_speed = 0.5

tufful_hp = 14
tufful_intro_landing_time = 117
tuffull_intro_roar_time = 178

configFog = {
	alpha1: 0.1,
	alpha2: 0.15,
	alpha3: 0.15,
	color: #94C8F2,
}

if DEV or DEMO {
	player_invincible = true
	player_hp_start = player_hp_max
	layer_hp = player_hp_start
	tufful_hp = 1
	audio_set_master_gain(0, 0)
}
