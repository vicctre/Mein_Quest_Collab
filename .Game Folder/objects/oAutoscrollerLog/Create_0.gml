event_inherited()

hsp = global.autoscroller_log_sp

image_speed = 0
delay_after_truncate = 60
timer = 0
shorten_sprites = [sLogShort1, sLogShort2, sLogShort3]

function TruncateByPinnik() {
	if timer {
		return;	
	}
	global.autoscroller_current_log_sprite_index++
	global.autoscroller_current_log_sprite_index
		= min(global.autoscroller_current_log_sprite_index, array_length(shorten_sprites) - 1)
	sprite_index = shorten_sprites[global.autoscroller_current_log_sprite_index]
	timer = delay_after_truncate
	audio_play_sound(global.sfx_bonk, 0, false)
	// increase speed if it is tiniest size of Log
	if global.autoscroller_current_log_sprite_index == (array_length(shorten_sprites) - 1) {
		global.player.start_log_ride()
		instance_destroy()
	}
}

function set_sprite_index(ind) {
	sprite_index = shorten_sprites[global.autoscroller_current_log_sprite_index]
}

dev_override()
