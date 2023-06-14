function draw_text_outlined(x_, y_, string_, text_color, outline_color){
	draw_set_color(outline_color);
	draw_text(x_+1, y_, string_);
	draw_text(x_-1, y_, string_);
	draw_text(x_, y_+1, string_);
	draw_text(x_, y_-1, string_);

	draw_set_color(text_color);
	draw_text(x_, y_, string_);
}