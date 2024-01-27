
event_inherited()

function on_destroy() {
	room_goto_next()
}

if global.skip_logos {
	instance_destroy()
}