
event_inherited()

visible = false

global.player.has_control = false
sequence = seqRularog_Intro02
//frame_roar = 179
destroy_delay = -1
sequence_inst = layer_sequence_create(
			layer, x, y, sequence)

roar_frame = 91

pause()
