

if mode == "grid" {
    draw_set_halign(fa_center)
    draw_set_valign(fa_bottom)
    draw_text_transformed(camx_cent(), draw_yst - 100, "Adventure logs", 2, 2, 0)
	for (var i = 0; i < array_length(grid); ++i) {
	    var yy = draw_yst + i * draw_ystep
	    for (var j = 0; j < array_length(grid[i]); ++j) {
	        var advlog = grid[i][j]
	        var xx = draw_xst + j * draw_xstep
            // draw log icon
            if unlocked_array[i * grid_cols + j] {
                draw_sprite_ext(advlog.sprite, 0, xx, yy, draw_scale, draw_scale, 0, c_white, 1)
                var rely = - sprite_get_yoffset(advlog.sprite) * draw_scale
                draw_set_font(fntMenu)
                draw_set_halign(fa_center)
                draw_set_valign(fa_top)
                // draw_text_transformed(xx, yy + rely, advlog.name, 0.5, 0.5, 0)
            } else {
                draw_sprite_ext(sAdvLog_Blank, 0, xx, yy, draw_scale, draw_scale, 0, c_white, 0.5)
            }
            // draw cursor
			if i == cursor.row and j == cursor.col {
				cursor.xto = xx
				cursor.yto = yy
                draw_sprite_ext(
                    sAdvlog_Select_UI,
                    frame * cursor.image_speed,
                    cursor.x, cursor.y,
                    draw_scale, draw_scale, 0, c_white, 1)
			}
	    }
	}
}

// middle of the screen
// draw_line(camw() * 0.5, 0, camw() * 0.5, room_height)
