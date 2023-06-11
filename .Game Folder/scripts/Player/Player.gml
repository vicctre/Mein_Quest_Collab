
function HealPlayer(amount) {
	global.player_hp = min(global.player_hp_max, global.player_hp+amount)
}
