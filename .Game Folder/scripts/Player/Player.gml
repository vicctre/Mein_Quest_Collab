
function HealPlayer(amount) {
	if global.player_hp < global.player_hp_max {
		global.player_hp = min(global.player_hp_max, global.player_hp+amount)
	}
}
