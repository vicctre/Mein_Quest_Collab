
wave_timer = make_timer(120)
phase = 0

wave_y = 0
wave_max_y = room_height + 32
wave_frame_index = 0
wave_angle_position = 0 // used as arg for lengthdir
wave_angle_speed = 0

// Waves animation params
// adjust speed to change, well... waves' speed
wave_anim_params = [
    { spr: sWave_Big, layer: layer_get_id("Wave1"), scale: 1, speed: 1, sfx: SFX_Wave3},
    { spr: sWave_Small, layer: layer_get_id("Wave2"), scale: 2, speed: 0.8, sfx: SFX_Wave2},
    { spr: sWave_Small, layer: layer_get_id("Wave3"), scale: 1, speed: 0.5, sfx: SFX_Wave1},
]


// Final wave params
final_wave = {
    speed: 4,   // how fast it falls
    ystart: -200,
    ymax: room_height * 1.25,   // how far beyond screen it goes
                                // basically defines a dealy before
                                // the ending edge appears
    spr: sWave_Big,
	layer: layer_get_id("FinalWave"),
    sfx: SFX_Wave3,

    active: false,
    y: 0,
    endy: 0,
}

wave_height_divider = 3 // 1, 2, 3
current_anim_params = wave_anim_params[wave_height_divider-1]
layer = layer_get_id(current_anim_params.layer)

instance_create_layer(0, 0, final_wave.layer, oW2WaveFinalWave)

function washEveryoneOff() {
    var x0 = camx(), x1 = x0 + camw(),
        y0 = final_wave.endy, y1 = final_wave.y
	with pCut {
        if !place_meeting(x, y, oSafeZone)
                and collision_rectangle(x0, y0, x1, y1, id, false, false) {
            dead_animation_fly_forward = true
            set_hit(1)
        }
        layer = layer_get_id("DeadObjects")
    }
    with oMein {
        if !place_meeting(x, y, oSafeZone)
                and collision_rectangle(x0, y0, x1, y1, id, false, false) {
            Hit(id)
        }
        layer = layer_get_id("DeadObjects")
    }
}

is_paused = false
function pause() {
    is_paused = true
}

function unpause() {
    is_paused = false
}
