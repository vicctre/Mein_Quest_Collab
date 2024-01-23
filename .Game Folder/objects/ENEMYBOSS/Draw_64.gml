var x_ = 750;
var y_ = 735;

draw_sprite_ext(sBossHP_bar, 0, x_, y_, 3, 3, 0, c_white, 1);
var hp_percent = hp/hp_max;
if (hp > 0) {
	draw_sprite_part_ext(sBossHP_health, 0, 0, 0, 183*hp_percent, 7, x_, y_, 3, 3, c_white, 1);
}