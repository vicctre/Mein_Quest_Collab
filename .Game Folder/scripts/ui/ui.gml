
function UiSlider(
		spr,
        padding,
        value, min_value, max_value,
        slider_w,
        xscale=1, yscale=1,
        mouse_control=true,
		collision_raduis=-1) constructor {
	self.spr = spr
    self.padding = padding
    self.sprw = sprite_get_width(spr)
    self.sprh = sprite_get_height(spr)
    self.slider_w = slider_w
    self.xscale = xscale
    self.yscale = yscale
    self.mouse_control = mouse_control

    self.value = clamp(value, min_value, max_value)
	self.min_value = min_value
	self.max_value = max_value

    self.x = 0
    self.y = 0
	self.collision_raduis = collision_raduis
	if self.collision_raduis == -1 {
		self.collision_raduis = sprh * 0.5	
	}
	
	self.is_captured = false
    self.slider_x_gain = (sprw - padding * 2 - slider_w) * xscale / (max_value - min_value)
    self.slider_xmin = padding * xscale
	self.filler_width_draw_gain = sprw / (max_value - min_value)
	
	function set_pos(xx, yy) {
		x = xx
		y = yy
	}
	
	function slider_x() {
        return self.slider_xmin + self.slider_x_gain * value
	}

	function filler_width() {
		return self.filler_width_draw_gain * value
	}
	
	function set_value(val) {
		value = clamp(val, min_value, max_value)
	}
	
	function check_is_captured() {
		return mouse_check_button_pressed(mb_left)
			   and (point_distance(x + slider_x(), y, mouse_x, mouse_y) < collision_raduis)
	}

	function step() {
        if mouse_control {
            if is_captured {
                set_value()
                is_captured = !mouse_check_button_released(mb_left)
            } else {
                is_captured = check_is_captured()
            }
        }
		perform_hook(self)
	}

    function draw() {
        draw_sprite_ext(spr, 0, x, y, xscale, yscale, 0, c_white, 1)
        if sprite_get_number(spr) == 3 {
            draw_sprite_part_ext(
                spr, 2, 0, 0, filler_width(), sprh,
                x + xscale * padding, y + yscale * padding,
                xscale, yscale, c_white, 1)
        }
        draw_sprite_ext(spr, 1, x + slider_x(), y, xscale, yscale, 0, c_white, 1)
    }

	function perform_hook(slf) {}
}

function FullnessBar(sprite=sFullnessBar, scale=1) constructor {
    bar_fullness = 1    // change this externally or in overriden update()
    self.sprite = sprite
    sprite_width = sprite_get_width(sprite)
    sprite_height = sprite_get_height(sprite)
    self.scale = scale

    draw = function(x, y) {
        update(self)
        draw_sprite_ext(sprite, 0, x, y, scale, scale, 0, c_white, 1)
        draw_sprite_part_ext(sprite,
                        1, 0, 0, 
                        bar_fullness * sprite_width, 
                        sprite_height,
                        x, y,
                        scale, scale, c_white, 1)
    }
    // override
    udpate = function() {}
}
