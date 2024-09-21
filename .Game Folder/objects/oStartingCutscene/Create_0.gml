
event_inherited()

x = room_width * 0.5
y = room_height * 0.5

//camera_set_view_size(cam, room_width, room_height)

sequences = [
    seqDemo2_pre_I1_XL,
    seqDemo2_pre_I2_XL,
]
sequence_ind = 0
sequence_inst = layer_sequence_create(layer, x, y, sequences[sequence_ind])
destroy_delay = 0

if DEV {
	layer_sequence_headpos(sequence_inst, layer_sequence_get_length(sequence_inst) - 300)
}

function on_destroy() {
	room_goto(rmTitleScreen)
}
