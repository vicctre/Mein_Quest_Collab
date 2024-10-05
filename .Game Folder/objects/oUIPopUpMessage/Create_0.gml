
if !ensure_singleton() {
    exit
}

messages = []
current_message = undefined
next_message = undefined

function Message(text) constructor {
    // set up text and box size
	max_width = 600
    padding = 20 //10
	sep = 42 //35
	text_max_width = max_width - padding * 2
    w = string_width_ext(text, sep, text_max_width) + padding * 2
	h = string_height_ext(text, sep, text_max_width) + padding * 2
	xscale = w / sprite_get_width(sPopUp)
	yscale = h / sprite_get_height(sPopUp)

	self.text = text
	yst = window_get_height() + 100
	yto = window_get_height() * 0.5 - h * 0.5
	y = yst
	x = window_get_width() * 0.5 - w * 0.5
	speed_ratio = 0.03
	time = 120
	ease_out = false
	is_done = false
    sound_played = false

	step = function() {
		if !ease_out {
			// y = approach2(y, yto, speed_ratio, 0.5)
            y = yto // appear on the screen instantly
			if (y == yto) and oInput.key_action {
				ease_out = true
			}
		} else {
            y = yst // go off screen instantly
			// y = approach2(y,
            //     yst + 200,              // increase yto to move faster
            //     speed_ratio, 0.5)
			if y >= yst {
				is_done = true
			}
		}
	}

	draw = function() {
		draw_set_valign(fa_top)
		draw_set_halign(fa_left)
		draw_sprite_ext(sPopUp, 0, x, y, xscale, yscale, 0, c_white, 1)
		draw_text_outlined(
            x + padding, y + padding, text,
            c_white, c_black, 2,
            sep, text_max_width)
        draw_sprite(sPopUpArrow, 0 , x + w - 40, y + h - 30) //PopUp Arrow in the bottom of the box
		// debug text box
		// draw_rectangle(x, y, x + w, y + h, true)
	}
}

function PopUp(text) {
    with oMenu {
        has_control = false
    }
	array_push(messages, new Message(text))
}

function CheckMessagesExist() {
    return (array_length(messages) > 0) or (current_message != undefined)
}
