
for (var i = 0; i < array_length(grid); ++i) {
    var yy = draw_yst + i * draw_ystep
    for (var j = 0; j < array_length(grid[i]); ++j) {
        var advlog = grid[i][j]
        var xx = draw_xst + j * draw_xstep
        draw_sprite_ext(advlog.sprite, 0, xx, yy, draw_scale, draw_scale, 0, c_white, 1)
    }
}

draw_line(camw() * 0.5, 0, camw() * 0.5, room_height)
