
event_inherited()

state = ENEMYSTATE.FREE; 
hitByAttack = ds_list_create(); 
deadSprite = -1;
baseX = x;
baseY = y;

enum ENEMYSTATE 
{
	FREE,
	ATTACKING,
	DEAD, 
	HIT, 	
}

