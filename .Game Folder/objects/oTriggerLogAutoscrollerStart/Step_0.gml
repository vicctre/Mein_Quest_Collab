
//// Start sequence and turn off player
if place_meeting(x, y, global.player)
		and !instance_exists(oSequenceLogAutoscrollerStart) {
    //// Make sure player is on ground when cutscene starts
    if global.player.down_free and global.player.is_hsp_control_on {
        with global.player {
            has_control = false
            hsp = 0
            hsp_to = 0
            setHspControl(false)
        }
    //// Start cutscene
    } else if !global.player.down_free {
        global.player.BecomeInvisibleIn(1)
        instance_create_layer(x, y, layer, oSequenceLogAutoscrollerStart)
        alarm[1] = 3 // delay destroy
    }
}
