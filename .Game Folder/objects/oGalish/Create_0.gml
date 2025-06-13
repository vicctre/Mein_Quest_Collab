event_inherited()

deadSprite = sGalish_D

trigger_range = 5 * 32
grav = 1

jump_sp = sqrt(grav * jump_height * 2)

vsp = 0
active = false
pause_timer = make_timer(60)
spawner = noone

function _set_hit() {
    if spawner {
        spawner.trigger()
    }
}
