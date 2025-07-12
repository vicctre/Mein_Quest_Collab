
if !active {
    if !pause_timer.update() {
        if abs(x - global.player.x) < trigger_range {
            active = true
            vsp = -jump_sp
        }
    }
} else {
    vsp += grav
	if vsp >= 0 and stall_in_air_timer.update() {
		vsp = 0	
	}
    y += vsp
    if y >= ystart {
        y = ystart
        vsp = 0
        active = false
        pause_timer.reset()
		stall_in_air_timer.reset()
    }
}

