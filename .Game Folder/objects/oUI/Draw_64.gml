
draw_hp_bar()

var scale = 2;
draw_sprite_ext(sCoinCounter, 0, 1230, 70, scale, scale, 0, c_white, 1);

var page_count = 3;
for(var i = 0; i < page_count; i++) {
	draw_sprite_ext(sAL_HUD, 0, 1260-65*page_count/2 + 65*i, 140, scale, scale, 0, c_white, 1);
	if (i < global.pages_placeholder)
		draw_sprite_ext(sAL_Icon, 0, 1260-65*page_count/2 + 65*i, 140, scale, scale, 0, c_white, 1);
}
draw_text_outlined(1220, 45, global.coins, c_white, c_black);

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