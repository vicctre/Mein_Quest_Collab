event_inherited();
collected = function() {
	repeat(7) {
		var inst = instance_create_depth(x+random(30)-15,y+random(30)-15,depth,oHealFizzle);
		inst.direction = point_direction(x, y, inst.x, inst.y);
		inst.speed = 0.5;
	}
}