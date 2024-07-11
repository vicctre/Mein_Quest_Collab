
var c = c_white
var yy = 120
var text = "Thanks for playing!\n"
var sclae = 2
draw_text_ext_transformed_color(camx_cent(0), camy(0) + yy, text, 0, 10000, sclae, sclae, 0,
								c, c, c, c, 1)
if goto_next_room_on {
	text = "Hope to see you soon with the next demo!\n"
		     + "Keep updated with @vicctre_dev on Twitter(X)\n"
			 + "Press X to go back to title menu"
	draw_text_color(camx_cent(0), camy(0) + yy + 120, text, c, c, c, c, 1)
}
