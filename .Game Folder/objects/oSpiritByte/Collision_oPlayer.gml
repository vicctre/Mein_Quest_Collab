
if path_speed < 0.1 {
	collected()
	oMusic.switch_music(global.msc_stage_clear, false, 0)
	instance_create_layer(0, 0, layer, oTransitionSpiritByteCollected)
	instance_destroy()
}
