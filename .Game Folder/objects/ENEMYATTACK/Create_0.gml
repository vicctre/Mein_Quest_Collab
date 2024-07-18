alarm[0] = 1
visible = DEV
if width != -1 {
	image_xscale = width / sprite_width
}
if height != -1 {
	image_yscale = height / sprite_height
}

if instance_exists(global.player)
		and place_meeting(x, y, global.player) {
	global.player.Hit()	
}
