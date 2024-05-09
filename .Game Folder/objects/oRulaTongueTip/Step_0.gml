

x += sp * image_xscale
dist_moved += sp

switch state {
	case TongueState.toss:
		state += (dist_moved > fast_move_dist)
		break
	case TongueState.pull:
		sp = approach(sp, -sp_max, decel)
		if dist_moved <= 0 {
			instance_destroy()
			exit
		}
		break
}


if oMein.is_grabbed() {
	oMein.x = x
	oMein.y = y
}
