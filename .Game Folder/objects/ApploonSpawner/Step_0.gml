
if (!paused) {
	counter++
	if (counter == spawn_delay) {
		counter = 0
		instance_create_layer(x, y, "Enemies", oApploon)
        
	} else if (counter % leaf_delay == 0  
            && counter >= leaf_fall_time 
            && counter < leaf_fall_time + leaf_delay * leaf_count) {
        spawn_leaf()
        if instance_exists(global.player) and abs(x - global.player.x) < leaf_sound_dist 
                and !audio_is_playing(global.sfx_leaf) {
            audio_play_sound(global.sfx_leaf, 0, false)
        }
	}
}
