
event_inherited()

name = "name not set, OOPS"
hp_max = 1;
hp = hp_max;
//for flying units
hsp_goal = hsp;
vsp_goal = vsp;

state = ENEMYSTATE.FREE; 
deadSprite = -1;
baseX = x;
baseY = y;
flying = false;
flysp = 0;
attacking = false;
hit_direction = 1

/* varialble definitions description
autoscroller_activate_distance - if not undefined will start moving only
								 when distance to right edge of camera = autoscroller_activate_distance
								 see oAutoscrollerController
*/

enum ENEMYSTATE {
	FREE,
	ATTACKING,
}

hit_blinking_timer = make_timer(10, false)
hit_blinking_gain = 180 / hit_blinking_timer.time
