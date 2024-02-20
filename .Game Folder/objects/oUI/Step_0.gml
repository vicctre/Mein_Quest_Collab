
hp_shake.step()
area_name_text_timer = max(0, area_name_text_timer - 1)


var player_gui_x = (oMein.x - scr_camx(0)) * display_get_gui_width() / scr_camw(0)
var player_gui_y = (oMein.y - scr_camy(0)) * display_get_gui_height() / scr_camh(0)
if point_distance(coin_counter_x, coin_counter_y, player_gui_x, player_gui_y) < 200 {
	coin_counter_alpha = approach(coin_counter_alpha, 0.35, 0.03)
} else {
	coin_counter_alpha = approach(coin_counter_alpha, 1, 0.03)
}
