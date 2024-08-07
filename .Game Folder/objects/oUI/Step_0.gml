
hp_shake.step()
area_name_text_timer = max(0, area_name_text_timer - 1)

//NOTE FROM MUFFIN: lerp the ui offset towards either -200 or 0, depending on whether UI_offscreen is toggled true or false
if (global.UI_Offscreen) {
	global.UI_y_offset = lerp(global.UI_y_offset, -200, 0.08);
} else {
	global.UI_y_offset = lerp(global.UI_y_offset, 0, 0.08);
}

if instance_exists(oMein) {
	var player_gui_x = (oMein.x - camx(0)) * display_get_gui_width() / camw(0)
	var player_gui_y = (oMein.y - camy(0)) * display_get_gui_height() / camh(0)
	if point_distance(coin_counter_x, coin_counter_y, player_gui_x, player_gui_y) < 200 {
		coin_counter_alpha = approach(coin_counter_alpha, 0.35, 0.03)
	} else {
		coin_counter_alpha = approach(coin_counter_alpha, 1, 0.03)
	}
}
