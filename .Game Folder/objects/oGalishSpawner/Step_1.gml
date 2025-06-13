if !spawned and !spawn_timer.update() {
    spawned = true
    instance_create_layer(x, y, layer, oGalish)
}
