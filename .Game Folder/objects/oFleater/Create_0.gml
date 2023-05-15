event_inherited();
deadSprite = sFleater_D;
flying = true;

switch (FlyPattern) {
	case "UpDown":
		hsp = 0;
		walksp = 0;
		vsp = 1;
	break;
	case "LeftRight":
		walksp = 1;
		flysp = 0;
	break;
	case "Still":
		hsp = 0;
		walksp = 0;
		flysp = 0;
	break;
}