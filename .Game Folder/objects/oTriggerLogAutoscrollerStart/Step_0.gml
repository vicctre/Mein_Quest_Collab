
//// Start sequence and turn off player
if place_meeting(x, y, global.player)
		and !instance_exists(oSequenceLogAutoscrollerStart) {
	instance_create_layer(x, y, layer, oSequenceLogAutoscrollerStart)
	alarm[1] = 3 // delay destroy

    with global.player {
        visible = false
        has_control = false
        hsp = 0
        hsp_to = 0
    }
}
