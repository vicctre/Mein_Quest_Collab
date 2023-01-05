
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
}

