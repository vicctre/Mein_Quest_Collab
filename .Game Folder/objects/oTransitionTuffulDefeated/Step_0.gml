
transition_timer--


switch phase {
	case 0:
		if !oPause.game_paused() {
			phase++
			oPlayer.has_control = false
			audio_play_sound(global.sfx_BOOM, 0, false)
			Screen_Shake(4, 30)
		}
		break
	case 1:
		if !oPlayer.down_free {
			phase++
			oPlayer.visible = false
			sequence_inst = layer_sequence_create(
					layer, oPlayer.x, oPlayer.y, sequence)
		}
		break
	case 2:
		if is_sequence_finished() {
			layer_sequence_speedscale(sequence_inst, 0)
		}
		if is_transition_finished() {
			SlideTransition(TRANS_MODE.GOTO, next_room)
			oMusic.switch_music(global.msc_stage_1_1)
		}
		break
}

