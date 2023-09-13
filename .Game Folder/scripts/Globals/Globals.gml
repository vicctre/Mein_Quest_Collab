/*
These are configs. There are different config value sets like Default and Dev.
You can change config in upper right corner of GM IDE.
Read more in manual.
*/
#macro Default:DEV false
#macro Dev:DEV true

coins = 0
coins_timer = 0 //for when coins flash yellow on collection
pages_placeholder = 0;
player_invincible = false

rooms_with_onto_stage_seq = [
	W1_1_part1,
	W1_2_part1,
]

music_gain_array = []


dev_level_goto = noone
if DEV {
	player_invincible = true
	dev_level_goto = W1_1_part4
}
