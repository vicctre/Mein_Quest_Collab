if path_index == noone {
	exit
}

							// prevent flying away
path_speed = sp * (1.1 - path_position) * (path_position < 1)

flickering_image_index += global.spirit_byte_flickering_image_speed
