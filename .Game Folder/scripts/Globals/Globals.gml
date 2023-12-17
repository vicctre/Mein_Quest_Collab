

// autoscroller checkpoint system
autoscroller_current_log_sprite = undefined
autoscroller_last_pinnik_controller = undefined
autoscroller_skip_log_intro = false

checkpoint = undefined
gui_adjusted = false
gui_workaround_restart_happened = false
logo_sequence_speed_scale = 1
music_gain_array = []
restart_level_on_death = true
skip_logos = false

function resetable_globals() {
	global.coins = 0
	global.coins_heal_amount = 100
	global.coins_timer = 0 //for when coins flash yellow on collection
	global.pages_placeholder = 0
	global.autoscroller_last_pinnik_controller = undefined
	global.autoscroller_current_log_sprite = undefined

	global.rooms_with_onto_stage_seq = [
		W1_1_part1,
		W1_2_part1,
	]


	global.dev_level_goto = noone
	if DEV {
		global.player_invincible = false
		global.dev_level_goto = W1_2_part4_AutoScroller1
		global.pages_placeholder = 1
		global.skip_logos = true
		global.autoscroller_skip_log_intro = true
	}
}
resetable_globals();