
event_inherited()


global.player.has_control = false
sequence = seqSS_Awaken01
oMein.visible = false
//frame_roar = 179
destroy_delay = -1
sequence_inst = layer_sequence_create(layer, x, y, sequence)
prev_sequence_instance = noone
prev_sequence = noone

notify_started()
