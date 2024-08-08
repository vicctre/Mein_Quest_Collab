
transition_timer -= transition_timer_on

switch phase {
	case 0:
		if !global.player.down_free {
			phase++
			global.player.visible = false
			global.player.has_control = false
			oMusic.switch_music(global.msc_stage_clear, false, 0)
			sequence_inst = layer_sequence_create(
					layer, global.player.x, global.player.y, sequence)
			if start_from_frame != undefined {
				layer_sequence_headpos(sequence_inst, start_from_frame)
			}
		}
		break
	case 1:
		if is_sequence_finished() {
			layer_sequence_speedscale(sequence_inst, 0)
		}
		if is_transition_finished() {
			RoomTransition(TRANS_MODE.GOTO, next_room, true)
			phase++
		}
		break
}
