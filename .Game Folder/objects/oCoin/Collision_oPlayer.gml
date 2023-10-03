
event_inherited()

if global.coins >= global.coins_heal_amount 
		and global.player_hp < global.player_hp_max {
	global.player_hp++
	global.coins -= global.coins_heal_amount 
}
