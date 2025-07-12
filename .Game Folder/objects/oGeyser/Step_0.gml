
if startup_timer.update() {
	exit
}

switch sprite_index {
    case sGeyser_Ground:
        if !pause_timer.update() {
            sprite_index = sGeyser_Ground_Prep
            pause_timer.reset()
        }
    break
    case sGeyser_Ground_Prep:
        if !prepare_timer.update() {
            sprite_index = sGeyser_Up
            prepare_timer.reset()
            image_yscale = 0
        }
    break
    case sGeyser_Up:
        image_yscale = min(image_yscale + yscale_speed, 1)
        if !geyser_timer.update() {
            sprite_index = sGeyser_End
            geyser_timer.reset()
        }
        with instance_place(x, y, global.player) {
            global.player.throw_with_control(other.image_angle + 90)
        }
    break
    case sGeyser_End:
        if is_animation_end() {
            sprite_index = sGeyser_Ground
        }
    break
}
