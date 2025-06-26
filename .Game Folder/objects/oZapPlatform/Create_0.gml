
zap_timer = make_timer(120, 0) // Timer for zap state duration
adjacent_positions = [
    {x: x + 1, y: y},     // Right
    {x: x - 1, y: y},     // Left  
    {x: x, y: y + 1},     // Down
    {x: x, y: y - 1}      // Up
]

function Zap() {
	// Set zap state by starting the timer
	zap_timer.reset()
	
	for (var i = 0; i < array_length(adjacent_positions); i++) {
		var pos = adjacent_positions[i]
		var adjacent_platform = instance_place(pos.x, pos.y, oZapPlatform)
		
		if (adjacent_platform != noone) {
			// Only trigger if the adjacent platform is not already zapped
			if (!adjacent_platform.IsJustZapped()) {
				adjacent_platform.Zap()
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
