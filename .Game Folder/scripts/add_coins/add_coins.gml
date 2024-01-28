global.coins_timer_max = 15;
function add_coins(amount) {
	global.coins += amount;

	if (global.coins >= global.coins_heal_amount && global.player_hp < global.player_hp_max_overheal) {
		global.player_hp++;
		global.coins -= global.coins_heal_amount;
	}
	// cap at 99 coins if max max health
	global.coins = min(global.coins_heal_amount - 1, global.coins);
	global.coins_timer = global.coins_timer_max;
}