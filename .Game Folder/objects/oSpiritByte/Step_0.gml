if path_index == noone {
	exit
}

							// prevent flying away
path_speed = sp * (1.1 - path_position) * (path_position < 1)
