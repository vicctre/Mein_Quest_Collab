
wave_frame_index += image_speed

switch phase {
    case 0:
        if !wave_timer.update() {
            phase++
        }
    break
    case 1:
        wave_y += wave_vspeed
        if wave_y > (wave_max_y / wave_height_divider) {
            phase++
        }
    break
    case 2:
        wave_y -= wave_vspeed
        if wave_y < 0 {
            wave_y = 0
			wave_height_divider--
			if wave_height_divider != 0 {
                current_anim_params = wave_anim_params[wave_height_divider - 1]
                layer = layer_get_id(current_anim_params.layer)
                image_speed = sprite_frames_per_step(current_anim_params.spr)
				phase--
				break
			}
            phase = 0
            wave_height_divider = 3
            wave_timer.reset()
        }
    break
}
