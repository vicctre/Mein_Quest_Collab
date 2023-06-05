function spawnHealFizzles() {
	for(var i = 0; i < 5; i++) {
		var inst = instance_create_depth(x,y,depth,oHealFizzle);
		inst.direction = 30 + 30*i
		inst.speed = 1;
	}
}