
scale = 4
image_xscale = scale
image_yscale = scale

text = ""
name = ""
name_rel_y = -275
text_rel_y = 30

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

    // override text position
    if variable_struct_exists(data, "name_rel_y") {
        name_rel_y = variable_struct_get(data, "name_rel_y")
    }
    if variable_struct_exists(data, "text_rel_y") {
        text_rel_y = variable_struct_get(data, "text_rel_y")
    }
}

function EaseOut() {
	is_ease_out = true
}
