if (fade) {
	speed = lerp(speed, 0, 0.02);
	image_alpha -= 1/30;
	image_blend = make_color_hsv(0, 0, 255*image_alpha);
	if (image_alpha <= 0)
		instance_destroy();
}