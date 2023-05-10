event_inherited();
collected = function() {
	//repeat(20) {
	//	var inst = instance_create_layer(x+random(30)-15,y+random(30)-15,layer,oCoinFizzle);
	//	inst.direction = 90+random(20)-10;
	//	inst.speed = 1;
	//}
	global.player_hp = min(global.player_hp_max, global.player_hp+1);
}