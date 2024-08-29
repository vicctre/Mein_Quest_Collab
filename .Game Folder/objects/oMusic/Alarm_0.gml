
audio_stop_sound(current_music)

if next_music == noone
	exit
	
var pos = next_music_pos
next_music_pos = 0

var msc_gain = get_gain(next_music)
show_debug_message(string("Gain: {0}", msc_gain))

// current_music_instance = audio_play_sound(
// 	next_music, 0, next_music_loops, 0)//, pos)
// audio_sound_gain(current_music_instance, msc_gain, next_music_transition_time_ms)

current_music_instance = audio_play_sound(next_music, 0, next_music_loops, 1, pos)
audio_sound_gain(next_music, 0, 0)
audio_sound_gain(next_music, msc_gain, next_music_transition_time_ms)

current_music = next_music
next_music = noone
