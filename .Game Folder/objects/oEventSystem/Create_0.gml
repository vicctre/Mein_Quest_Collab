
/*
Simple event system. Add new events in Events enum.
Use Subscribe method in event listeners
*/

if !ensure_singleton() {
	exit
}

enum Events {
	stage_exit, // go back to menu
	__last,
}

// event name -> list of subscirbers
events_registry = ds_map_create()

// init events registry
for (var i = 0; i < Events.__last; ++i) {
    events_registry[? i] = []
}

function CheckEventExists(event) {
    if !ds_map_exists(events_registry, event) {
		throw ("Event with index " + event + " doesn't exist")
	}
}

function Subscribe(event, callback) {
	CheckEventExists(event)
	if !array_contains(events_registry[? event], callback) {
		array_push(events_registry[? event], callback)
	}
}

function Notify(event) {
	CheckEventExists(event)
	var callbacks = events_registry[? event]
	for (var i = 0; i < array_length(callbacks); ++i) {
	    callbacks[i]()
	}
}




