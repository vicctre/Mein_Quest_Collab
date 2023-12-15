
event_inherited()

//for flying units
hsp_goal = hsp;
vsp_goal = vsp;

state = ENEMYSTATE.FREE; 
hitByAttack = ds_list_create(); 
deadSprite = -1;
baseX = x;
baseY = y;
flying = false;
flysp = 0;
attacking = false;

/* varialble definitions description
autoscroller_activate_distance - if not undefined will start moving only
								 when distance to right edge of camera = autoscroller_activate_distance
								 see oAutoscrollerController
*/

enum ENEMYSTATE 
{
	FREE,
	ATTACKING,
	DEAD, 
	HIT, 	
}