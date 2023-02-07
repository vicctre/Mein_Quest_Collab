
function set_hit(damage=0) { 
	hp -= damage
	flash = true
	if (hp > 0) {
		state = ENEMYSTATE.HIT 
		hitNow = true
	}
	else {
		state = ENEMYSTATE.DEAD
	}
	
	//
	var player = instance_find(oPlayer, 0);
	test = sign(x-oPlayer.x);
}

