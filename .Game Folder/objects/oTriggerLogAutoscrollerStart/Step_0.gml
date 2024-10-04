
//// Start sequence and turn off player
if place_meeting(x, y, global.player)
		and !instance_exists(oSequenceLogAutoscrollerStart) {
    with global.player {
        has_control = false
        hsp = 0
        hsp_to = 0
        setHspControl(false)
    }
    //// Make sure player is on ground when cutscene starts
    if !global.player.down_free {
        instance_create_layer(x, y, layer, oSequenceLogAutoscrollerStart)
        global.player.BecomeInvisibleIn(2)
        alarm[1] = 3 // delay destroy
    }
}
