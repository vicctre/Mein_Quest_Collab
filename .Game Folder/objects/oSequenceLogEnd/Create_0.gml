
event_inherited()

// took from the sequence
play_landing_sound_frame = 95
player_rel_x_appear = 353 - 206

sequence = seqLogEnd
sequence_inst = layer_sequence_create(layer, x, y, sequence)

visible = false
global.player.visible = false
global.player.has_control = false

unpause()
notify_started()
