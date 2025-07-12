event_inherited()

deadSprite = sGalish_D

trigger_range = 5 * 32
grav = 0.12

jump_sp = sqrt(grav * jump_height * 2)

vsp = 0
active = false
pause_timer = make_timer(80)
stall_in_air_timer = make_timer(30)
spawner = noone

function _set_hit() {
    if spawner {
        spawner.trigger()
    }
}
