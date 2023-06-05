event_inherited();
collected = function() {
	spawnHealFizzles();
	global.player_hp = min(global.player_hp_max, global.player_hp+3);
}