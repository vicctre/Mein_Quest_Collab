
if instance_number(object_index) > 1 {
	instance_destroy()
	exit
}

show_debug_message("Create: " + string(id))

current_music = noone
current_music_instance = noone
next_music = noone
music_transition_time_ms = 1000
next_music_transition_time_ms = music_transition_time_ms
next_music_loops = undefined
next_music_pos = 0

function get_gain(msc) {
	var not_in_array = array_length(global.music_gain_array) <= msc
	if not_in_array
			or (!not_in_array and global.music_gain_array[msc] == 0) {
		global.music_gain_array[msc] = audio_sound_get_gain(msc)
		show_debug_message(string("Added gain: {0}", audio_sound_get_gain(msc)))
	}
	return global.music_gain_array[msc]
}

function switch_music_pos(msc, pos, loops=true, transition_time=music_transition_time_ms) {
	switch_music(msc, loops, transition_time)
	next_music_pos = pos
}

function switch_music(msc, loops=true, transition_time=music_transition_time_ms) {
	next_music_transition_time_ms = transition_time
	next_music_loops = loops
	if current_music != noone {
		alarm[0] = next_music_transition_time_ms / 1000 * 60
		audio_sound_gain(current_music, 0, next_music_transition_time_ms)
	}
	alarm[0] = max(1, alarm[0])
	next_music = msc
}

function CurrentMusic() {
	return current_music
}

function CurrenMusicTrackPosition() {
	if !audio_exists(current_music_instance) {
		return
	}
	return audio_sound_get_track_position(current_music_instance)
}
