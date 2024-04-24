
x += sp * image_xscale
dist_moved += sp
if throwing_phase and dist_moved > fast_move_dist {
	throwing_phase = false
} else {
	sp = approach(sp, -sp_max, decel)
	if dist_moved <= 0 {
		instance_destroy()	
	}
}
