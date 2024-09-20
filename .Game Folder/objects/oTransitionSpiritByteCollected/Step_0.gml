
switch phase {
	case 0:
		if !global.player.down_free {
			phase++
			global.player.start_boss_end_sequence()
		}
		break
	case 1:
		if !global.player.is_boss_sequence() {
			phase++
			global.player.has_control = false
			oMusic.switch_music(victory_music, false, 0)
			sequence_inst = layer_sequence_create(
					layer, global.player.x, global.player.y, sequence)
			if start_from_frame != undefined {
				layer_sequence_headpos(sequence_inst, start_from_frame)
			}
		}
		break
	case 2:
        // turn off player's visibility here
        // to prevent one-frame blink caused by some sort of sequence start delay
        global.player.visible = false
		if is_sequence_finished() {
			layer_sequence_speedscale(sequence_inst, 0)
            phase++
		}
    break
	case 3:
		if !transition_end_timer.update() {
            if room == W1_3BOSS
                    and !oStageManager.IsPogoUnlocked() {
                global.player_pogo_just_unlocked = true // trigger pogo unclocking
                                                        // on stage select
            }
			RoomTransition(TRANS_MODE.GOTO, next_room, true)
			phase++
		}
    break
}
