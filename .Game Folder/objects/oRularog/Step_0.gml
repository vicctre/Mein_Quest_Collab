

state.step()
var new_state = state.checkChange()
if new_state != undefined {
	state.onExit()
	state = new_state
	new_state.onEnter()
}

if !leaf_timer.update() {
    leaf_timer.reset()
}
if (leaf_timer.timer >= leaf_fall_time
        && leaf_timer.timer % leaf_delay == 0) {
    spawn_leaf()
}
