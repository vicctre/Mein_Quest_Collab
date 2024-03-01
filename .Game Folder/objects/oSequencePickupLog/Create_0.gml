
//time = audio_sound_length(global.sfx_adventure_log) * 60 + 1
time = 90

x = oMein.x
y = oMein.y
oMein.visible = false
image_xscale = oMein.image_xscale
oPause.PauseWithTimer(time)
music_prev = oMusic.current_music
oMusic.switch_music(global.sfx_adventure_log, false, 0)

alarm[0] = time
