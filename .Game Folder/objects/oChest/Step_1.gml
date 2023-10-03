if (hp <= 0) {
	instance_create_layer(x,y,layer,oChestOpen);
	var inst = instance_create_depth(x,y,depth-1,contained_item);
	inst.activated = false;
	instance_destroy(); 
	audio_play_sound(global.sfx_chest, 0, false);
}

