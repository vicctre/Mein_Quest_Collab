event_inherited();
collected = function() {
	repeat(10) {
		var inst = instance_create_depth(x+random(30)-15,y+random(30)-15,depth,oCoinFizzle);
		inst.direction = 90+random(20)-10;
		inst.speed = 1;
	}
	global.coins++;
}