
transition_timer -= transition_timer_on

switch phase {
	case 0:
		if !oPlayer.down_free {
			phase++
			oPlayer.visible = false
			oPlayer.has_control = false
			oMusic.switch_music(global.msc_stage_clear, false, 0)
			sequence_inst = layer_sequence_create(
					layer, oPlayer.x, oPlayer.y, sequence)
		}
		break
	case 1:
		if is_sequence_finished() {
			layer_sequence_speedscale(sequence_inst, 0)
		}
		if is_transition_finished() {
			SlideTransition(TRANS_MODE.GOTO, next_room)
			var msc = next_room == rmAdventureLogsScreen ? global.msc_adv_log_screen : global.msc_stage_1_1
			oMusic.switch_music(msc)
		}
		break
}
