
var c = c_white
var yy = 120
var text = "Thanks for playing Mein's Quest DEMO 2!\n"
var sclae = 2
draw_text_ext_transformed_color(camx_cent(0), camy(0) + yy, text, 0, 10000, sclae, sclae, 0,
								c, c, c, c, 1)
if goto_next_room_on {
	text = "We would love feedback for the final release.\n"
		     + "Keep updated on Itch.io or my Twitter(X) @vicctre_dev. Hope to see ya next time\n"
			 + "Press enter/A to go back to menu and something EXTRA!"
	draw_text_color(camx_cent(0), camy(0) + yy + 120, text, c, c, c, c, 1)
}
