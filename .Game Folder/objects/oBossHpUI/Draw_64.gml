

draw_set_halign(fa_right);
draw_text(draw_x + 540, draw_y - 56 + y_offset, target.name);
	
draw_sprite_ext(sBossHP_barV2, 0, draw_x, draw_y + y_offset, 3, 3, 0, c_white, 1);
var hp_percent = target.hp/target.hp_max;
if (hp_percent > 0) {
	var sprite = sBossHP_healthV2;
	var width = sprite_get_width(sprite);
	draw_sprite_part_ext(
        sprite, 0, 0, 0, width*hp_percent,
        7, draw_x, draw_y + y_offset, 3, 3, c_white, 1);
}
