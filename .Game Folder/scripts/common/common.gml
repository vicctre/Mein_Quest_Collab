
function perform_attack(spr, xscale, dmg) {
	instance_create_layer(x, y, "Player", oAttack, {sprite_index: spr, image_xscale: xscale, damage: dmg})
	attack_performed = true
}
