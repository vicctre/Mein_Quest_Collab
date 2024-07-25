
if is_paused {
    exit
}

wave_frame_index += image_speed

switch phase {
    case 0:
        if !wave_timer.update() {
            phase++
            ////////////
            //if DEV {
                // phase = 2
                // wave_height_divider = 1
            //}
            ////////////
            current_anim_params = wave_anim_params[wave_height_divider-1]
            layer = current_anim_params.layer
            image_speed = sprite_frames_per_step(current_anim_params.spr)
            wave_angle_speed = current_anim_params.speed
            wave_angle_position = 0
            audio_play_sound(current_anim_params.sfx, 0, false)
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
                layer = current_anim_params.layer
                image_speed = sprite_frames_per_step(current_anim_params.spr)
                wave_angle_speed = current_anim_params.speed
                wave_angle_position = 0
                if wave_height_divider == 1 {
                    phase++
                    audio_play_sound(final_wave.sfx, 0, false)
                } else {
                    audio_play_sound(current_anim_params.sfx, 0, false)
                }
				break
			}
            phase = 0
            wave_height_divider = 3
            wave_timer.reset()
        }
    break
    case 2:
        wave_angle_position += wave_angle_speed
        wave_y = -lengthdir_y(wave_max_y / wave_height_divider, wave_angle_position)
        if wave_angle_position >= 90 {
            phase++
            final_wave.active = true
            final_wave.endy = 0
            final_wave.y = final_wave.ystart
            audio_play_sound(final_wave.sfx, 0, false)
        }
    break
    case 3:
        final_wave.y += final_wave.speed
        if final_wave.y > final_wave.ymax {
            phase++
        }
		washEveryoneOff()
    break
    case 4:
        final_wave.endy += final_wave.speed
        wave_y = room_height - final_wave.endy // third wave follows final wave
        if final_wave.endy > final_wave.ymax {
            phase = 0
            wave_height_divider = 3
            wave_timer.reset()
            final_wave.active = false
            current_anim_params = undefined // turn off background waves
        }
		washEveryoneOff()
    break
}
