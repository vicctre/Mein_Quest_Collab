
if is_sequence_finished() {
    if sequence == seqSS_Awaken01 {
        sequence = seqSS_Victory01
        layer_sequence_destroy(sequence_inst)
        sequence_inst = layer_sequence_create(
                layer, x, y, sequence)
        instance_create_layer(x, y, layer, oTransitionSpiritByteCollected)
    } else {
        instance_destroy()
    }
}

if DEV and oInput.key_attack {
	layer_sequence_speedscale(sequence_inst, 10)
}
