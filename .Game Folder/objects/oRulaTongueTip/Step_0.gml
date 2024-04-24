
x += sp * image_xscale
dist_moved += sp
if throwing_phase {
	throwing_phase = (dist_moved < fast_move_dist)
} else {
	sp = approach(sp, -sp_max, decel)
	if dist_moved <= 0 {
		instance_destroy()	
	}
}
