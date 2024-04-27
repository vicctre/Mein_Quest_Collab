
target = noone

draw_x = 750
draw_y = 735

y_offset_on = true
y_offset_max = 100
y_offset = y_offset_max
y_offset_speed = 2

function ease_in() {
	y_offset_on = false
}

function ease_out() {
	y_offset_on = true
}

