global.coins_timer_max = 15;
function add_coins(amount) {
	global.coins += amount;

	if (global.coins >= global.heal_coins_number && global.player_hp < global.player_hp_max_overheal) {
		global.player_hp++;
		global.coins -= global.heal_coins_number;
	}
	// cap at 99 coins if max max health
	global.coins = min(global.heal_coins_number - 1, global.coins);
	global.coins_timer = global.coins_timer_max;
}