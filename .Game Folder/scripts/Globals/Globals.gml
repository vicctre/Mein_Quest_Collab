/*
These are configs. There are different config value sets like Default and Dev.
You can change config in upper right corner of GM IDE.
Read more in manual.
*/

gui_adjusted = false
music_gain_array = []
gui_workaround_restart_happened = false
logo_sequence_speed_scale = 1
restart_level_on_death = true
skip_logos = false

function resetable_globals() {
	global.coins = 0
	global.coins_heal_amount = 100
	global.coins_timer = 0 //for when coins flash yellow on collection
	global.pages_placeholder = 0

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
	}
}
resetable_globals();