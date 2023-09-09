
transition_timer--


switch phase {
	case 0:
		if !oPause.game_paused() {
			phase++
			audio_play_sound(global.sfx_BOOM, 0, false)
			Screen_Shake(4, 30)
			oTuffull.spirit_byte_drop_timer = oTuffull.spirit_byte_drop_time
		}
		break
}
