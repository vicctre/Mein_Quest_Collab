global.coins_timer_max = 15;
function add_coins(amount) {
	global.coins += amount;
	global.coins = global.coins % 100;
	global.coins_timer = global.coins_timer_max;
}