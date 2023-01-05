
function UiSlider(
		spr,
        width,
        value,
        min_value,
        max_value,
		collision_raduis=-1) constructor {
	self.spr = spr
    self.sprw = sprite_get_width(spr)
    self.sprh = sprite_get_height(spr)
    self.draw_x_off = sprw * 0.5
    self.draw_y_off = sprh * 0.5
    self.total_width = width
    self.width = max(0, width - sprw)

    self.value = clamp(value, min_value, max_value)
	self.min_value = min_value
	self.max_value = max_value
    self.slider_rel_x = (value - min_value) / max_value * self.width

    self.X = 0
    self.Y = 0
	self.collision_raduis = collision_raduis
	if self.collision_raduis == -1 {
		self.collision_raduis = sprh * 0.5	
	}
	
	self.is_captured = false
	
	function set_pos(xx, yy) {
		X = xx
		Y = yy
	}
	
	function set_value() {
		value = lerp(min_value, max_value, slider_rel_x/width)	
	}
	
	function check_is_captured() {
		return mouse_check_button_pressed(mb_left)
			   and (point_distance(X + slider_rel_x, Y, mouse_x, mouse_y) < collision_raduis)
	}

	function step() {
		if is_captured {
			slider_rel_x = clamp(mouse_x - X, 0, width)
			set_value()
			is_captured = !mouse_check_button_released(mb_left)
		} else {
			is_captured = check_is_captured()
		}
		perform_hook(self)
	}

    function draw() {
        draw_sprite_stretched(spr, 0, X - draw_x_off, Y - draw_y_off, total_width, sprh)
        draw_sprite(spr, 1, X + slider_rel_x, Y)
		draw_text_custom(X + total_width + 10, Y, value, fnt, fa_center, fa_middle)
    }
	
	function perform_hook(slf) {}
}
