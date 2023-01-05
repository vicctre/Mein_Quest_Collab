
event_inherited()

state = ENEMYSTATE.FREE; 
hitByAttack = ds_list_create(); 

enum ENEMYSTATE 
{
	FREE,
	ATTACKING,
	DEAD, 
	HIT, 	
}

