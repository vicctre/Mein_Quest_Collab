
function StartTuffulDefeatedTransition() {
	oPlayer.has_control = false
	oPlayer.visible = false
	instance_create_layer(0, 0, "Instances", oTransitionTuffulDefeated)
}
