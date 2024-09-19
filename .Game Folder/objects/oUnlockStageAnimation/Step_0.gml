
if follow and phase != 3 {
    x = follow.getx()
    y = follow.gety()
}

if oUIPopUpMessage.CheckMessagesExist() {
    exit
}

switch phase {
	// delay before unlocking animtion
    case 0:
        if !phase0_timer-- {
            phase++
            image_speed = 1
        }
    break
	// play unlock animation
    case 1:
		if is_animation_at_frame(3) {
			audio_play_sound(SFX_Stage_Unlock, 3, false)
		}
        if is_animation_end() {
            phase++
            image_speed = 0
            image_index = image_number - 1
        }
    break
	// delay before "jump"
    case 2:
        if !phase2_timer-- {
            phase++
			audio_play_sound(global.sfx_stage_unlock_wiff, 3, false)
        }
    break
	// "jump"
    case 3:
        white_alpha -= 0.02
        image_angle += rotation_sp
        x += hsp
        y += vsp
        vsp += grav
        if y > (window_get_height() + 500) {
            instance_destroy()
        }
    break
}
