
/*
Simple event system. Add new events in Events enum.
Use Subscribe method in event listeners.
*/

if !ensure_singleton() {
	exit
}

enum Events {
	stage_exit, // go back to menu
	stage_restart,
	cutscene_start,
	cutscene_end,
	__last,
}

// event name -> inst id -> array of callbacks
events_registry = ds_map_create()

// init events registry
for (var i = 0; i < Events.__last; ++i) {
    events_registry[? i] = ds_map_create()
}

function CheckEventExists(event) {
    if !ds_map_exists(events_registry, event) {
		throw ("Event with index " + event + " doesn't exist")
	}
}

function Subscribe(event, id, callback) {
	CheckEventExists(event)
	// use inst id as a second key
	// as ds_map_exists fails to find pure callbacks
	if !ds_map_exists(events_registry[? event], id) {
		events_registry[? event][? id] = [callback]
	} else if !array_contains(events_registry[? event][? id], callback) {
		array_push(events_registry[? event][? id], callback)
	}
}

function UnSubscribe(event, id) {
	CheckEventExists(event)
	if ds_map_exists(events_registry[? event], id) {
		ds_map_delete(events_registry[? event], id)
	}
}

function Notify(event) {
	CheckEventExists(event)
	var callbacks_map = events_registry[? event]
	var keys = ds_map_keys_to_array(callbacks_map)
	for (var i = 0; i < array_length(keys); ++i) {
		var inst_id = keys[i]
		//if !instance_exists(inst_id) {
		//	ds_map_delete(callbacks_map, inst_id)
		//	return;
		//}
		var inst_callbacks = callbacks_map[? inst_id]
		for (var j = 0; j < array_length(inst_callbacks); ++j) {
		    inst_callbacks[j]()
		}
	}
}




