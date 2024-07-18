
with oW2Wave {
    if final_wave.active {
        var xst = camx(), w = camw(), h = room_height
        var xend = camx() + camw()
        var spr = final_wave.spr
        var sw = sprite_get_width(spr)
        draw_set_color(#0A2F76)
        for (var i = 0; i < (w / sw + 1); ++i) {
            draw_sprite_ext(spr, wave_frame_index, xst + sw * i, final_wave.y, 1, -1, 0, c_white, 1)
            draw_sprite_ext(spr, wave_frame_index, xst + sw * i, final_wave.endy, 1, 1, 0, c_white, 1)
        }
        draw_rectangle(xst, final_wave.y, xend, final_wave.endy, false)
        draw_set_color(c_white)
    }
}
