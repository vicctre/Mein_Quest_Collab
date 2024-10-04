
frame = 0
current_sounds = []

function PlayAt(snd, frame_, gain=1, loops=false) {
	if frame != frame_ {
		return
	}
	array_push(current_sounds, audio_play_sound(snd, 3, loops, gain))
}

