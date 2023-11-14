if (!paused) {
	counter++;
	if (counter == spawn_delay) {
		counter = 0;
		instance_create_layer(x, y, "Enemies", oApploon);
	}
}