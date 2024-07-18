event_inherited()
cooldown = max(0, cooldown-1)

if (attacking) {
	image_index += 0.2
	if (image_index == 7) {
        show_debug_message("attack")
		var inst = instance_create_layer(x, y, layer, oChantie_Attack)
		inst.image_xscale = image_xscale
		audio_play_sound(global.sfx_whip, 0, false)
	}
	if (image_index == image_number) {
		attacking = false
		sprite_index = sChantieIdle
		cooldown = cooldown_max
	}
}

var xDiff = abs(global.player.x-x)
var yDiff = abs(global.player.y-y)
if (xDiff <= 80 && yDiff <= 30) {
	if (!attacking && cooldown == 0) {
		attacking = true
		sprite_index = sChantieCycle
		image_index = 0
	}
}