
wave_frame_index += image_speed

switch phase {
    case 0:
        if !wave_timer.update() {
            phase++
            current_anim_params = wave_anim_params[2]
            layer = layer_get_id(current_anim_params.layer)
            image_speed = sprite_frames_per_step(current_anim_params.spr)
            wave_angle_speed = current_anim_params.speed
            wave_angle_position = 0
        }
    break
    case 1:
        wave_angle_position += wave_angle_speed
        wave_y = -lengthdir_y(wave_max_y / wave_height_divider, wave_angle_position)
        if wave_angle_position > 180 {
            wave_y = 0
			wave_height_divider--
            // pick next layer and start previous phase again
			if wave_height_divider != 0 {
                current_anim_params = wave_anim_params[wave_height_divider - 1]
                layer = layer_get_id(current_anim_params.layer)
                image_speed = sprite_frames_per_step(current_anim_params.spr)
                wave_angle_speed = current_anim_params.speed
                wave_angle_position = 0
				break
			}
            phase = 0
            wave_height_divider = 3
            wave_timer.reset()
        }
    break
}
