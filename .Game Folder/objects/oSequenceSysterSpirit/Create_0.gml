
event_inherited()


global.player.has_control = false
sequence = seqSS_Awaken01
oMein.visible = false
//frame_roar = 179
destroy_delay = -1
sequence_layer = "Leafage"
sequence_inst = layer_sequence_create(
			sequence_layer, x, y, sequence)

notify_started()
