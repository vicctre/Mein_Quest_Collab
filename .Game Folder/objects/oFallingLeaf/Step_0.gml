if oPause.paused {
	image_speed = 0;
	exit;
}
image_speed = 1;

y += spd;
if (fade) {
	spd = lerp(spd, 0, 0.02);
	image_alpha -= 1/30;
	image_blend = make_color_hsv(0, 0, 255*image_alpha);
	if (image_alpha <= 0)
		instance_destroy();
}