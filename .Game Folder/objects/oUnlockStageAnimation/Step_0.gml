
switch phase {
    case 0:
        if !phase0_timer-- {
            phase++
            image_speed = 1
        }
    break
    case 1:
        if is_animation_end() {
            phase++
            image_speed = 0
            image_index = image_number - 1
        }
    break
    case 2:
        if !phase2_timer-- {
            phase++
        }
    break
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

if follow and phase != 3 {
    x = follow.getx()
    y = follow.gety()
}
