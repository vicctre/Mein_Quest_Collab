
spawn_time = 4 * 60
spawn_timer = make_timer(spawn_time)
spawned = false

function trigger() {
    spawned = false
    spawn_timer.reset()
}





