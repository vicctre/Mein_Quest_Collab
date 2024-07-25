
draw_text_above_me(string("{0} {1}", image_xscale, image_yscale))

draw_self()

if hit_blinking_timer.update() {
	draw_hit_blinking(hit_blinking_timer.timer * hit_blinking_gain,
                      global.enemy_hit_blinking_color)
}
