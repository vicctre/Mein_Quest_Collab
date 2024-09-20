
if IsStageRoom(room) {
	UnlockStage(room)
}

if !game_options.tutorials and layer_exists("Tutorials") {
	layer_set_visible("Tutorials", false)
}
