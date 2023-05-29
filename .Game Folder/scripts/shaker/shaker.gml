
function Shaker() constructor {
	time = 30
	timer = 0
	rot_magnitude = 5

	angle = 0

	step = function() {
		if !timer {
			angle = 0
			return;
		}
		timer--
		angle = random_range(-rot_magnitude, rot_magnitude)
	}

	shake = function() {
		timer = time
	}
}
