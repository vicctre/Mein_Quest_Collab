
event_inherited()

state = ENEMYSTATE.FREE; 
hitByAttack = ds_list_create(); 
deadSprite = -1;

enum ENEMYSTATE 
{
	FREE,
	ATTACKING,
	DEAD, 
	HIT, 	
}

