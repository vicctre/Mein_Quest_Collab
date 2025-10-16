
zap_timer = make_timer(global.molli_zap_time, 0) // Timer for zap state duration
adjacent_positions = [
    {x: x + 1, y: y},     // Right
    {x: x - 1, y: y},     // Left  
    {x: x, y: y + 1},     // Down
    {x: x, y: y - 1}      // Up
]

// Zap platofrm can be any length
// we use an array of sprites to animate them
sprites = []
width = 32
image_speed = 0

function Zap(zapped_platforms) {
	// Set zap state by starting the timer
    array_push(zapped_platforms, id)
	zap_timer.reset()
	image_speed = 1
	for (var i = 0; i < array_length(adjacent_positions); i++) {
		var pos = adjacent_positions[i]
		var adjacent_platform = instance_place(pos.x, pos.y, oZapPlatform)

		if (adjacent_platform != noone) {
			// Only trigger if the adjacent platform is not already zapped
			if (!adjacent_platform.IsJustZapped()) {
				adjacent_platform.Zap(zapped_platforms)
			}
		}
	}
}

function IsZap() {
    return zap_timer.timer > 0
}

function IsJustZapped() {
    return zap_timer.timer == zap_timer.time
}

function UnZap() {
    zap_timer.reset(0)
}

function InitSprites() {
    var scale = abs(image_xscale)
    if scale == 1 {
        array_push(sprites, sZapPlat_01)
        return;
    }
    array_push(sprites, sZapPlat_02)
    for (var i = 1; i < scale - 1; ++i) {
        array_push(sprites, sZapPlat_04)
    }
    array_push(sprites, sZapPlat_03)
}

InitSprites()
