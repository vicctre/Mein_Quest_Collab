
event_inherited()

idleState = {
    id: id,
	step: function() {

    },
	onExit: function() {

    },
	onEnter: function() {

    },
	checkChange: function() {
        return id.walkState
    },
}

jumpChargeState = {
    id: id,
	charge_timer: make_timer(60),
	
	step: function() {

    },
	
	onExit: function() {

    },
	
	onEnter: function() {

    },
	
	checkChange: function() {
        return id.walkState
    },
}

walkState = {
    id: id,
    sp: 2,
    room_center_x: room_width * 0.5,
    dir: 1,
	change_state: false,
	
	step: function() {
        with id {
            if place_meeting(x + other.dir, y, oWall) {
                other.dir = -other.dir
				image_xscale = other.dir
            }
			var sp = other.sp * other.dir
			scr_move_coord_contact_obj(sp, 0, oWall)
        }
    },
	
	onExit: function() {
		change_state = false
    },
	
	onEnter: function() {
        id.sprite_index = sRulaWalk
    },
	
	checkChange: function() {
        if change_state {
			return id.jumpChargeState	
		}
		return undefined
    },
}

state = idleState
