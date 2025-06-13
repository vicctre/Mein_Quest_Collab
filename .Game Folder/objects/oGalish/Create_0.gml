event_inherited()

deadSprite = sGalish_D

trigger_range = 5 * 32
grav = 0.2

jump_sp = sqrt(grav * jump_height * 2)

vsp = 0
active = false
pause_timer = make_timer(80)
spawner = noone

function _set_hit() {
    if spawner {
        spawner.trigger()
    }
}
