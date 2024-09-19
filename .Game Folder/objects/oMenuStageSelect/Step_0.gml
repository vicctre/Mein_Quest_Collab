
event_inherited()

if !has_control {
    exit
}

if oInput.key_escape
		and !animation_is_playing // prevent exiting while animation is playing
{
	PerformGoBack()
	audio_play_sound(global.sfx_select, 7, false)
}

if adv_log_play_animation_index > -1 {
	adv_log_play_animation_frames += adv_log_play_animation_sp
	if adv_log_play_animation_frames >= sprite_get_number(sAdvLogIconAnimation) {
		adv_log_play_animation_index = -1
		adv_log_play_animation_frames = 0
	}
}

if menu_cursor_prev != menu_cursor {
	adv_log_play_animation_index = menu_cursor
	adv_log_play_animation_frames = 0
}

menu_cursor_prev = menu_cursor

