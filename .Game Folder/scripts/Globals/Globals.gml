

// autoscroller checkpoint system
autoscroller_current_log_sprite_index = -1
autoscroller_reached_pinnik_controllers = []
autoscroller_skip_log_intro = false

// parallax background settings
bgr1_xoffset = 0
bgr2_xoffset = 0
bgr3_xoffset = 0
bgr1_parallax = 0.5
bgr2_parallax = 0.7
bgr3_parallax = 0.9

// make camera bounds act as walls
camera_solid_bounds_on = false
checkpoint = undefined
coins = 0
coins_timer = 0
gui_adjusted = false
gui_workaround_restart_happened = false
logo_sequence_speed_scale = 1
music_gain_array = []
player = oMein
restart_level_on_death = true
skip_logos = false
available_stages = [
	W1_1_part1,
	W1_1_part2,
	W1_1_part3,
	W1_1_part4,
	W1_1_part5,
	W1_2_part1,
	W1_2_part2,
	W1_2_part3,
	W1_2_part4_AutoScroller1,
	W1_2_part5_AutoScroller2,
]

function level_reset_globals() {
	global.coins = 0
	global.coins_timer = 0 // for when coins flash yellow on collection
	global.camera_solid_bounds_on = false
	global.player_hp = global.player_hp_max
}

function game_reset_globals() {
	level_reset_globals()
	global.autoscroller_current_log_sprite_index = -1
	global.autoscroller_reached_pinnik_controllers = []
	global.rooms_with_onto_stage_seq = [
		W1_1_part1,
		W1_2_part1,
	]


	global.dev_level_goto = noone
	if DEV {
		global.coins = 50
		global.player_invincible = false
		global.skip_logos = true
		//global.autoscroller_skip_log_intro = true
	}
}

function dev_override() {
	if !DEV
		return;
	switch room {
		case W1_2_part4_AutoScroller1:
			switch object_index {
				case oMein:
					x = 8100
					break
				case oAutoscrollerLog:
					x = 8100
					sprite_index = sLogShort2
					global.autoscroller_current_log_sprite_index = 1
					break
			}
			break
	}
}

game_reset_globals()

lose_coins_counter = 0
lose_coins_time = 120
lose_coins_punishment = 30
