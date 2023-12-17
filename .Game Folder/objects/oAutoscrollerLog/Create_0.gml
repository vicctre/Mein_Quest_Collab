event_inherited()

hsp = global.autoscroller_log_sp

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
	current_sprite_index = min(current_sprite_index, array_length(shorten_sprites) - 1)
	sprite_index = shorten_sprites[current_sprite_index]
	global.autoscroller_current_log_sprite = sprite_index
	timer = delay_after_truncate
	audio_play_sound(global.sfx_bonk, 0, false)
	// increase speed if it is tiniest size of Log
	if current_sprite_index == (array_length(shorten_sprites) - 1) {
		hsp = global.autoscroller_log_sp_increased	
	}
}
