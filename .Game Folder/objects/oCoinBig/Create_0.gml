event_inherited();
sound_effect = global.sfx_coin;
collected = function() {
	for(var i = 0; i < 8; i++) {
		var inst = instance_create_depth(x,y,depth,oCoinFizzle);
		inst.direction = i*45;
		inst.speed = 0.5;
	}
	add_coins(50);
	audio_play_sound(sound_effect, 0, false);
}
