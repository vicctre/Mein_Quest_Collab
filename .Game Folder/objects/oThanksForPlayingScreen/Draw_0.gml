
var c = c_white
var yy = 120
var text = "Thanks for playing\nMein's Quest DEMO 2!\n"
var sclae = 2
draw_set_halign(fa_center)
draw_text_transformed_color(camx_cent(), camy() + yy, text,
								sclae, sclae, 0,
								c, c, c, c, 1)
if goto_next_room_on {
	text = "We would love feedback for the final release.\n"
		     + "Keep updated on Itch.io or my Twitter(X) @vicctre_dev.\nHope to see ya next time\n"
			 + "Press enter/X/A to go back to menu and get something EXTRA!"
	draw_text_color(camx_cent(), camy() + yy + 240, text, c, c, c, c, 1)
}
