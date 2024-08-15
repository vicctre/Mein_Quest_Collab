
if is_unlocked {
    event_inherited()
} else {
    draw_sprite_ext(
		sAdvLog_Blank, 0, x, y, 
        image_xscale, image_yscale,
        0, c_white, 0.5)
}
