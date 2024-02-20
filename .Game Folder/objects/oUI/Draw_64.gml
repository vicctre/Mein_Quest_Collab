
draw_set_font(fMenu)

draw_hp_bar()

draw_set_alpha(coin_counter_alpha)

draw_sprite_ext(sCoinCounter, 0,
				coin_counter_x, coin_counter_y,
				scale, scale, 0, c_white, coin_counter_alpha)

var gap = 70
var y_shift = 137
for(var i = 0; i < stage_logs_num; ++i) {
	draw_sprite_ext(sAL_HUD, 0,
					1260-65*stage_logs_num/2 + gap*i, y_shift,
					scale, scale, 0, c_white, coin_counter_alpha)
	if (stage_logs[$ stage_log_names[i]].unlocked) {
		draw_sprite_ext(sAdvLogIconAnimation, 0, 
						1260-65*stage_logs_num/2 + gap*i, y_shift,
						scale, scale, 0, c_white, coin_counter_alpha)
	}
}

draw_set_halign(fa_center)
draw_set_valign(fa_top)
var xx = 1246
var yy = 48
if (global.coins_timer > 0) {
	global.coins_timer--
	shader_set(YellowShader)
	var uniform = shader_get_uniform(YellowShader, "yellow_alpha")
	shader_set_uniform_f(uniform, 0.5-abs(0.5-global.coins_timer/global.coins_timer_max))
	draw_text_outlined(xx, yy, global.coins, text_color, outline_color)
	shader_reset()
} else {
	draw_text_outlined(xx, yy, global.coins, text_color, outline_color)
}
if (global.lose_coins_counter > 0) {
	global.lose_coins_counter--
	var yy_shift = min(120, 300*(global.lose_coins_time-global.lose_coins_counter)/global.lose_coins_time)
	draw_text_outlined(xx, yy + yy_shift, string(-global.lose_coins_punishment), lose_coins_color, outline_color)
}
draw_set_alpha(1)


// draw area name shortly after entering
if (area_name_text_timer > 0) {
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	var text = get_stage_name(room)
	var text_y = display_get_gui_height() - area_name_text_offset
	var text_width = string_width(text)
	
	draw_set_color(c_black)
	draw_set_alpha(area_name_text_background_opacity)
	draw_rectangle(0, text_y+5, text_width + 60, text_y + 40, false)
	draw_set_alpha(1)
	draw_text_outlined(40, text_y, text, c_white, c_black)
	
	if (area_name_text_timer > area_name_text_timer_max/2)
		area_name_text_offset = lerp(area_name_text_offset, 100, 0.05)
	else
		area_name_text_offset = area_name_text_offset 
								- max(0.3, lerp(area_name_text_offset, 101, 0.05) - area_name_text_offset)
}


checkpoint_indicator.draw()