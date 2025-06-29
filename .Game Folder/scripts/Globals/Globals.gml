
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
lose_coins_counter = 0
lose_coins_time = 120
lose_coins_punishment = 30

goto_stage_select = false
gui_adjusted = false
gui_workaround_restart_happened = false
logo_sequence_speed_scale = 1
music_gain_array = []
player = oMein
player_pogo_just_unlocked = false // show pop up message
player_reset_hp = false
room_prev = noone
rula_start_state = undefined
rula_intro_cutscene_played = false
restart_level_on_death = true
skip_logos = false
stage_select_show_unlock_animation = false

//// Used by various systems
boss_stages = [W1_1_part5, W1_3BOSS]

function level_reset_globals() {
	global.coins_timer = 0 // for when coins flash yellow on collection
	global.camera_solid_bounds_on = false
	global.player_hp = max(global.player_hp, global.player_hp_max)
}

function game_reset_globals() {
	level_reset_globals()
	global.coins = 0
	global.rooms_with_onto_stage_seq = [
		W1_1_part1,
		W1_2_part1,
		W2_1_part1,
	]
    global.rula_intro_cutscene_played = false

	global.dev_level_goto = noone //Change what room Dev mode opens on 
	if DEV {
		global.coins = 50
		global.player_invincible = false
		// global.skip_logos = true
		// global.dev_level_goto = rmThanksForPlayingScreen
		// global.dev_level_goto = rmMenuAdventureLogsScreen
         //global.dev_level_goto = W1_3BOSS
        // global.dev_level_goto = W2_1_part5
        global.dev_level_goto = W2_2_part3
		// global.rula_start_state = "tongueChargeState"
		// global.autoscroller_skip_log_intro = true
        // audio_set_master_gain(0, 0)
	}
}

function dev_override() {
	if !DEV
		return;
	//switch room {
        //// debug autoscroller log shortening
		// case W1_2_part4_AutoScroller1:
		// 	switch object_index {
		// 		case oMein:
		// 			x = 8100
		// 			break
		// 		case oAutoscrollerLog:
		// 			x = 8100
		// 			sprite_index = sLogShort2
		// 			global.autoscroller_current_log_sprite_index = 1
		// 			break
		// 	}
        // break

        //// debug autoscroller start cutscene
		// case W1_2_part3:
		// 	oMein.x = 860
        // break
	//}
}

game_reset_globals()

