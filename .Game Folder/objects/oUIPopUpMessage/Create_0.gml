
if !ensure_singleton() {
    exit
}

messages = []

function Message(text) constructor {
	self.text = text
	yst = window_get_height() + 10
	y = yst
	yto = window_get_height() - 200
	x = 100
	speed_ratio = 0.03
	time = 120
	ease_out = false
	is_done = false
	
	step = function() {
		if !ease_out {
			y = approach2(y, yto, speed_ratio, 0.5)
			if (y == yto) and !time-- {
				ease_out = true
			}
		} else {
			y = approach2(y, yst, speed_ratio, 0.5)
			if y == yst {
				is_done = true
			}
		}
	}
	
	draw = function() {
		draw_sprite(sPopUp, 0, x, y)
	}
}

function Add(text) {
	array_push(messages, new Message(text))
}
