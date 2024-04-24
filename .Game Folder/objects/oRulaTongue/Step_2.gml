
if !instance_exists(tongue_tip) {
	instance_destroy()
	exit
}

image_xscale = tongue_tip.dist_moved * tongue_tip.image_xscale
