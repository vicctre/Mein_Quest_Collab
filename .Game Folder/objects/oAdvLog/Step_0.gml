
var xto = !is_ease_out ? scr_camw(0) * 0.5 : -sprite_width * 0.5

if abs(x - xto) > spd {
	x -= spd
}

if is_ease_out and x >= xto {
	instance_destroy()
}
