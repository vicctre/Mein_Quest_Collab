/* marked for deletion?
function EnemyHit()
{
	var _damage = argument0; 

	hp -= _damage; 
	if (hp > 0) 
	{
		state = ENEMYSTATE.HIT 
		hitNow = true; 
	}
	else 
	{
		state = ENEMYSTATE.DEAD; 
	}
}