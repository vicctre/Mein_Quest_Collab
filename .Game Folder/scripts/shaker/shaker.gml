
function Shaker() constructor {
	time = 30
	timer = 0
	rot_magnitude = 5
	frequency = 10

	phase_sp = 360 * frequency / 60

	angle = 0

	step = function() {
		if !timer {
			angle = 0
			return;
		}
		timer--
		angle = lengthdir_x(rot_magnitude * timer / time, phase_sp*timer)
	}

	shake = function() {
		timer = time
	}
}
