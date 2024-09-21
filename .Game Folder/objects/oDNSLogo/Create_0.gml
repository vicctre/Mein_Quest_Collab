
event_inherited()
sequence = seqDNSLogo
sequence_inst = layer_sequence_create(layer, x, y, sequence)
layer_sequence_speedscale(sequence_inst, global.logo_sequence_speed_scale)

function on_destroy() {
    if DEMO {
        room_goto(rmStartingCutscene)
    } else {
        room_goto_next()
    }
}
