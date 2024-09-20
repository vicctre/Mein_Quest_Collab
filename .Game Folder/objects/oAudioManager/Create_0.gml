
sfxs = []
bgms = []
bgm_gain = 1

var i = 0
while audio_exists(i) {
    var name = audio_get_name(i)
    if (string_starts_with(name, "BGM")) {
        bgms[i] = audio_sound_get_gain(i)
    } else if string_starts_with(name, "SFX") {
        sfxs[i] = audio_sound_get_gain(i)
    } else {
		show_debug_message("Unexpected name for audio asset " + name)	
	}
    i++
}

function SetSfxGain(value) {
	for (var i = 0; i < array_length(sfxs); ++i) {
        audio_sound_gain(i, sfxs[i] * value, 0)
    }
}

function SetBgmGain(value) {
	for (var i = 0; i < array_length(bgms); ++i) {
        audio_sound_gain(i, bgms[i] * value, 0)
    }
    bgm_gain = value
}

function GetBgmGain(bgm) {
    return bgms[bgm] * bgm_gain
}
