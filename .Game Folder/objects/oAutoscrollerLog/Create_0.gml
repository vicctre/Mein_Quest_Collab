event_inherited()

hsp = global.autoscroller_log_sp

image_speed = 0
delay_after_truncate = 60
timer = 0
shorten_sprites = [sLogShort1, sLogShort2, sLogShort3]
switch_to_log_ride_when_mein_on_log = false

function SetShortedSpriteEarly() {
    //// Increase sprite index early
    // fixes the game crash if Mein fails after reaching checkpoint but before
    // log truncating
	global.autoscroller_current_log_sprite_index++
	global.autoscroller_current_log_sprite_index
		= min(global.autoscroller_current_log_sprite_index, array_length(shorten_sprites) - 1)
}

function TruncateByPinnik() {
	if timer {
		return;	
	}
	sprite_index = shorten_sprites[global.autoscroller_current_log_sprite_index]
	timer = delay_after_truncate
	audio_play_sound(global.sfx_bonk, 0, false)
	// increase speed if it is tiniest size of Log
	if global.autoscroller_current_log_sprite_index == (array_length(shorten_sprites) - 1) {
		switch_to_log_ride_when_mein_on_log = true
		oMusic.switch_music(global.msc_stage1_2_2)
	}
}

function set_sprite_index(ind) {
	sprite_index = shorten_sprites[global.autoscroller_current_log_sprite_index]
}

dev_override()
