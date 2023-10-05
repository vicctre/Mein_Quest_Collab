
if path_speed < 0.1 {
	collected()
	instance_create_layer(0, 0, layer, oTransitionSpiritByteCollected)
	instance_destroy()
}
