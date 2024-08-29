function draw_text_outlined(x_, y_, string_, text_color, outline_color, thickness=1, sep=0, w=infinity) {
	draw_set_color(outline_color)
	draw_text_ext(x_+thickness, y_, string_, sep, w)
	draw_text_ext(x_-thickness, y_, string_, sep, w)
	draw_text_ext(x_, y_+thickness, string_, sep, w)
	draw_text_ext(x_, y_-thickness, string_, sep, w)

	draw_set_color(text_color)
	draw_text_ext(x_, y_, string_, sep, w)
}