function spawnHealFizzles() {
	for(var i = 0; i < 5; i++) {
		var inst = instance_create_depth(x,y,depth,oHealFizzle);
		inst.direction = 90 + 15*(i-2)
		inst.x += lengthdir_x(5, inst.direction);
		inst.y += lengthdir_y(5, inst.direction);
		inst.speed = 2.5;
		inst.y -= 8;
		inst.startY = y;
	}
}