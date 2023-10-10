/*
These are configs. There are different config value sets like Default and Dev.
You can change config in upper right corner of GM IDE.
Read more in manual.
*/
#macro Default:DEV false
#macro Dev:DEV true


gui_adjusted = false
music_gain_array = []


function resetable_globals() {
	global.coins = 0
	global.coins_heal_amount = 100
	global.coins_timer = 0 //for when coins flash yellow on collection
	global.pages_placeholder = 0;
	global.player_invincible = false

	global.rooms_with_onto_stage_seq = [
		W1_1_part1,
		W1_2_part1,
	]


	global.dev_level_goto = noone
	if DEV {
		global.player_invincible = true
		global.dev_level_goto = W1_1_part4
	}
}
resetable_globals();