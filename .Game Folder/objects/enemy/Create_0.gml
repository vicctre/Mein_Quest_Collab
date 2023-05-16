
event_inherited()

state = ENEMYSTATE.FREE; 
hitByAttack = ds_list_create(); 
deadSprite = -1;
baseX = x;
baseY = y;
leashRange = 100;
flying = false;
flysp = 0;
attacking = false;

enum ENEMYSTATE 
{
	FREE,
	ATTACKING,
	DEAD, 
	HIT, 	
}

