
wave_timer = make_timer(120)
phase = 0

wave_y = 0
wave_max_y = room_height + 32
wave_frame_index = 0
wave_angle_position = 0 // used as arg for lengthdir
wave_angle_speed = 0

wave_anim_params = [
    { spr: sWave_Big, layer: "Wave1", scale: 1, speed: 1},
    { spr: sWave_Small, layer: "Wave2", scale: 2, speed: 0.8},
    { spr: sWave_Small, layer: "Wave3", scale: 1, speed: 0.5},
]
wave_height_divider = 3 // 1, 2, 3
current_anim_params = wave_anim_params[wave_height_divider-1]
layer = layer_get_id(current_anim_params.layer)
