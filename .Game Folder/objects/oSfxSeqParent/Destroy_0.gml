
for (var i = 0; i < array_length(current_sounds); ++i) {
    var snd = current_sounds[i]
    if audio_is_playing(snd) {
		audio_stop_sound(snd)
	}
}
