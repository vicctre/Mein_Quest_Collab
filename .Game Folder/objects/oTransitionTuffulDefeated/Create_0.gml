
event_inherited()

next_room = W1_2_part1
destroy_delay = 120
sequence = seqPlayerVictory

oMusic.switch_music(global.msc_stage_clear, false)
transition_timer = 7 * 60

phase = 0
oPause.PauseWithTimer(60)
Screen_Shake(3, 30)

function is_transition_finished() {
	return !transition_timer
}
