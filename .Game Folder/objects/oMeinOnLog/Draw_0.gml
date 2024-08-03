
draw_self()
if invincibility_timer.update() {
	draw_hit_blinking(hit_blinking_gain * invincibility_timer.timer)
}
