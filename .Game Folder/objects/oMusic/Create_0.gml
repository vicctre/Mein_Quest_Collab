
if instance_number(object_index) > 1 {
	instance_destroy()
	exit
}

current_music = noone
next_music = noone
music_transition_time = 60
music_transition_time_ms = 1000
gain_array = []

function get_gain(msc) {
	var not_in_array = array_length(gain_array) < msc+1
	if not_in_array
			or (!not_in_array and gain_array[msc] == 0) {
		gain_array[msc] = audio_sound_get_gain(msc)
	}
	return gain_array[msc]
}

function switch_music(msc) {
	alarm[0] = 1
	if current_music != noone {
		alarm[0] = music_transition_time
		audio_sound_gain(current_music, 0, music_transition_time_ms)
	}
	next_music = msc
}
