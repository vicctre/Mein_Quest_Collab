if instance_exists(oMeinOnLog) {
	x = max(x, oMeinOnLog.x)
}

image_alpha = alarm[0] > 60 ? 1 : alarm[0] / 60
