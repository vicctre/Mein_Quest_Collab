if !spawned and !spawn_timer.update() {
    spawned = true
    with instance_create_layer(x, y, layer, oGalish, {
        jump_height: jump_height
    }) {
        spawner = other
    }
}
