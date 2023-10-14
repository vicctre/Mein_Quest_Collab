
// remove dev doors and labels
if DEMO {
	with oDoor {
		if for_development {
			instance_destroy()	
		}
	}
	delete_layer_sprite("door_to_part2")
	delete_layer_sprite("door_to_part3")
	delete_layer_sprite("door_to_boss")	
}
