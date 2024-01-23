var x_ = 750;
var y_ = 735;

draw_set_halign(fa_right);
draw_text(x_ + 540, y_ - 50, name);
	
draw_sprite_ext(sBossHP_barV2, 0, x_, y_, 3, 3, 0, c_white, 1);
var hp_percent = hp/hp_max;
if (hp > 0) {
	var sprite = sBossHP_healthV2;
	var width = sprite_get_width(sprite);
	draw_sprite_part_ext(sprite, 0, 0, 0, width*hp_percent, 7, x_, y_, 3, 3, c_white, 1);
}