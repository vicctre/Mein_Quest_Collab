
frame = 0

visible = false

function PlayAt(snd, frame_, gain=1, loops=false) {
	if frame != frame_ {
		return
	}
	audio_play_sound(snd, 3, loops, gain)
}