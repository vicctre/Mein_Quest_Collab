event_inherited();
deadSprite = sFleater_D;
flying = true;

switch (FlyPattern) {
	case "UpDown":
		hsp = 0;
		hsp_goal = hsp;
		walksp = 0;
		vsp = 1;
		vsp_goal = vsp;
	break;
	case "LeftRight":
		walksp = 1;
		flysp = 0;
	break;
	case "Still":
		hsp = 0;
		hsp_goal = hsp;
		walksp = 0;
		flysp = 0;
	break;
}
if (id == instance_find(oFleater, 0))
show_debug_message(y)