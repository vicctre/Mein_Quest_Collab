
draw_hp_bar()

var scale = 2;
var color = c_white;
var color2 = c_black;


draw_sprite_ext(sCoinCounter, 0, 1230, 70, scale, scale, 0, c_white, 1);

var page_count = 1;
for(var i = 0; i < page_count; i++) {
	draw_sprite_ext(sAL_HUD, 0, 1260-65*page_count/2 + 65*i, 140, scale, scale, 0, c_white, 1);
	if (global.pages_placeholder > 0) {
		draw_sprite_ext(sAL_Icon_animation, global.pages_placeholder, 1260-65*page_count/2 + 65*i, 140, scale, scale, 0, c_white, 1);
		global.pages_placeholder = min(29, global.pages_placeholder+0.5);
	}
}


var xx = 1246
var yy = 48
if (global.coins_timer > 0) {
	global.coins_timer--;
	shader_set(YellowShader);
	uniform = shader_get_uniform(YellowShader, "yellow_alpha");
	shader_set_uniform_f(uniform, 0.5-abs(0.5-global.coins_timer/global.coins_timer_max));
	draw_text_outlined(xx, yy, global.coins, color, color2);
	shader_reset();
} else {
	draw_text_outlined(xx, yy, global.coins, color, color2);
}
/*
if (instance_exists(oTransitionTuffulDefeated)) {
	draw_text_outlined(1320, 50, global.coins, c_white, c_black);	
}*/

if (area_name_text_timer > 0) {
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	var text = get_stage_name(room);
	var text_y = display_get_gui_height() - area_name_text_offset;
	var text_width = string_width(text);
	
	draw_set_color(c_black);
	draw_set_alpha(area_name_text_background_opacity);
	draw_rectangle(0, text_y+5, text_width + 60, text_y + 40, false);
	draw_set_alpha(1);
	draw_text_outlined(40, text_y, text, c_white, c_black);
	
	if (area_name_text_timer > area_name_text_timer_max/2)
		area_name_text_offset = lerp(area_name_text_offset, 100, 0.05);
	else
		area_name_text_offset = area_name_text_offset - max(0.3, lerp(area_name_text_offset, 101, 0.05) - area_name_text_offset);
}