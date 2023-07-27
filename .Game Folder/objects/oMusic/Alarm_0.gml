
audio_stop_sound(current_music)

if next_music == noone
	exit

var msc_gain = get_gain(next_music)
audio_play_sound(next_music, 0, true)
audio_sound_gain(next_music, 0, 0)
audio_sound_gain(next_music, msc_gain, music_transition_time)
current_music = next_music
next_music = noone
