
function perform_attack(spr, xscale, dmg, one_frame=true) {
	var inst = instance_create_layer(x, y, "Player", oAttack, 
		{sprite_index: spr, image_xscale: xscale, damage: dmg, one_frame: one_frame})
	attack_performed = true
	return inst
}
