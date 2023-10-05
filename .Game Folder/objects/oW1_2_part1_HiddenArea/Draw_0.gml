
if !oPause.paused {
	if place_meeting(x, y, oPlayer) {
		image_alpha = approach(image_alpha, 0.15, draw_alpha_ratio)
	} else {
		image_alpha = approach(image_alpha, 1, draw_alpha_ratio)
	}
}

draw_set_alpha(image_alpha)

var i = 0
var w = sprite_get_width(sprite_index)
repeat draw_repeat {
	draw_sprite(sprite_index, 0, x + w * i, y)
	i++
}

draw_set_alpha(1)
