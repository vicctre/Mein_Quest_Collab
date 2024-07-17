
if is_sequence_finished() {
    if sequence == seqSS_Awaken01 {
        sequence = seqSS_Victory01
        prev_sequence = sequence_inst
        sequence_inst = layer_sequence_create(
                sequence_layer, x, y, sequence)
    } else {
        instance_create_layer(x, y, layer, oTransitionSpiritByteCollected)
        instance_destroy()
        layer_sequence_destroy(prev_sequence)
    }
}

if DEV and oInput.key_attack {
	layer_sequence_speedscale(sequence_inst, 10)
}
