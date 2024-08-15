
scale = 4
image_xscale = scale
image_yscale = scale

text = ""
name = ""

x = camw() + sprite_width * 0.6
y = camh() * 0.5
spd = 15
is_ease_out = false

function Init(creature) {
    var data
    if is_struct(creature) {
        data = creature
        name = data.name
    } else { // string
        data = global.adventure_logs[$ creature]
        name = creature
    }
	text = data.description
	sprite_index = data.sprite
}

function EaseOut() {
	is_ease_out = true
}
