

state.step()
var new_state = state.checkChange()
if new_state != undefined {
	state.onExit()
	state = new_state
	new_state.onEnter()
}
