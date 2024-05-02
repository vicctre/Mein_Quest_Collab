
event_inherited()

visible = false

global.player.has_control = false
sequence = seqRularog_Intro01
oRularog.state = oRularog.inactiveState
oRularog.visible = false
//frame_roar = 179
destroy_delay = -1
sequence_inst = layer_sequence_create(
			layer, x, y, sequence)

notify_started()
