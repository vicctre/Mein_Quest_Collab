event_inherited();
collected = function() {
	for(var i = 0; i < 8; i++) {
		var inst = instance_create_depth(x,y,depth,oCoinFizzle);
		inst.direction = i*45;
		inst.speed = 0.5;
	}
	global.coins++;
}