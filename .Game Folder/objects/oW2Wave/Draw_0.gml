
var yy = room_height - wave_y
draw_line(camx(), yy, camx() + camw(), yy)

if phase == 1 or phase == 2 {
    var w = camw(), h = room_height
    var spr = current_anim_params.spr
    var scale = current_anim_params.scale 
    var sw = sprite_get_width(spr) * scale
    for (var i = 0; i < (w / sw + 1); ++i) {
        draw_sprite_ext(spr, wave_frame_index, sw * i, yy, scale, scale, 0, c_white, 1)
    }
    draw_set_color(#0A2F76)
    draw_rectangle(camx(), yy + sprite_get_height(spr)*scale, camx() + camw(), room_height, false)
    draw_set_color(c_white)
}
