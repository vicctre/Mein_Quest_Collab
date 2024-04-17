
event_inherited()

hp = 22

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

jumpState = {
    id: id,
	prepare_timer: make_timer(15),
	is_jumping: false,
	hsp: 0,
	vsp: 0,
	vsp_max: 10,
	jump_sp: -7,
	grav: 0.2,
	jumps_total: 3,
	jumps_left: 3,
	jump_delay: make_timer(30),

	step: function() {
		if !is_jumping {
			if !prepare_timer.update() {
				is_jumping = true
				vsp = jump_sp
				jumps_left--
				id.sprite_index = sRulaJumpUp
			}
		} else {
			vsp = approach(vsp, vsp_max, grav)
			with id {
				if other.vsp > 0 {
					sprite_index = sRulaFalling	
				}
				scr_move_coord_contact_obj(0, other.vsp, oWall)
				if place_meeting(x, y + 1, oWall) {
					other.vsp = 0
					other.is_jumping = false
					other.prepare_timer.reset()
					sprite_index = sRulaJumpPrep
					oCamera.start_shaking()
				}
			}
		}
	},
	
	onExit: function() {
		change_state = false
    },
	
	onEnter: function() {
		id.sprite_index = sRulaJumpPrep
		jumps_left = jumps_total
    },
	
	checkChange: function() {
        if !jumps_left and !is_jumping {
			return id.idleState
		}
		return undefined
    },
}

jumpChargeState = {
    id: id,
	charge_timer: make_timer(135),
	
	step: function() {},
	
	onExit: function() {
		charge_timer.reset()
    },
	
	onEnter: function() {
		id.sprite_index = sRulaCharge
    },
	
	checkChange: function() {
        if !charge_timer.update() {
			return id.jumpState		
		}
		return undefined
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
				other.change_state = true
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

//// Leafs
leaf_timer = make_timer(45)
leaf_delay = 2
leaf_number = 7
// leaf_number - 1 will provide leafs to change spawning pattern
leaf_hoffset_divider = leaf_number - 1
leaf_fall_time = leaf_timer.time - leaf_number * leaf_delay

leaf_counter = 0
leaf_distance = 15
function spawn_leaf() {
	// this basically runs leaf_counter in cycles
	leaf_counter = (leaf_counter + 2) % leaf_hoffset_divider
	var h_offset = leaf_distance * (1 - leaf_counter / 2)
	instance_create_layer(x + h_offset, 50, "Enemies", oFallingLeaf)
}






















