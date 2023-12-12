
image_speed = 0
delay_after_truncate = 60
timer = 0
shorten_sprites = [sLogShort1, sLogShort2, sLogShort3]
current_sprite_index = -1

function TruncateByPinnik() {
	if timer {
		return;	
	}
	current_sprite_index++
	current_sprite_index = min(current_sprite_index, array_length(shorten_sprites))
	sprite_index = shorten_sprites[current_sprite_index]
	timer = delay_after_truncate
	audio_play_sound(global.sfx_bonk, 0, false)
}
