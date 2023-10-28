
var c = c_white
var yy = 150
var text = "Thanks for playing!\n"
if goto_next_room_on
	text += "Hope to see you soon with the next demo!\n"
		     + "Keep updated with @vicctre_dev on Twitter(X)\n"
			 + "Press X to go back to title menu"

draw_text_color(scr_camx_cent(0), scr_camy(0) + yy, text, c, c, c, c, 1)
