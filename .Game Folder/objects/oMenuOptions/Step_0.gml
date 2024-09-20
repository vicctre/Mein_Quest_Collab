
event_inherited()

if !has_control {
    exit
}

if oInput.key_back
		and !animation_is_playing // prevent exiting while animation is playing
{
	PerformGoBack()
	audio_play_sound(global.sfx_select, 7, false)
}
