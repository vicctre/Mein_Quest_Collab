
if oPause.paused
	exit

if switch_to_log_ride_when_mein_on_log and global.player.is_on_log {
	global.player.start_log_ride()
	instance_destroy()
}

x += hsp
timer--
