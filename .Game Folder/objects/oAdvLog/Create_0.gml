
scale = 4
image_xscale = scale
image_yscale = scale

text = ""
name = ""

x = scr_camw(0) + sprite_width * 0.6
y = scr_camh(0) * 0.5
spd = 15
is_ease_out = false

function Init(creature_name) {
	var data = global.adventure_logs[$ creature_name]
	name = creature_name
	text = data.description
	sprite_index = data.sprite
}

function EaseOut() {
	is_ease_out = true
}
