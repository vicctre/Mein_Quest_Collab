event_inherited();
cooldown = max(0, cooldown-1);
var dir = sign(oPlayer.x-x);
if (!attacking)
	image_xscale = dir;


if (attacking) {
	image_index += 0.2;
	if (image_index == 6) {
		var inst = instance_create_layer(x, y, layer, oShante_Attack);
		inst.image_xscale = image_xscale;
	}
	if (image_index == image_number) {
		attacking = false;
		sprite_index = sShanteeIdle;
		cooldown = cooldown_max;
	}
}

var xDiff = abs(oPlayer.x-x);
var yDiff = abs(oPlayer.y-y);
if (xDiff <= 80 && yDiff <= 30) {
	if (!attacking && cooldown == 0) {
		attacking = true;
		sprite_index = sShanteeCycle;
		image_index = 0;
	}
}