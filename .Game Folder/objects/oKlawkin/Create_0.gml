event_inherited()
deadSprite = sEnemy01Ded

wanderState = {
    id: id,
    sp: 0.5,
    dir: 1,

	step: function() {
        id.move(sp * dir, 0)
		var check_ground_x = dir ? id.bbox_right : id.bbox_left
        if id.colliding_wall(id.x + dir, id.y)
                or !collision_point(check_ground_x, id.bbox_bottom + 1,
                                    oWall, false, false) {
            dir = -dir
        }
    },
	onExit: function() {

    },
	onEnter: function() {
        id.sprite_index = sKlawkin
    },
	checkChange: function() {
        if id.attackUpState.checkTriggered() {
            return id.attackUpState
        }
        if id.attackSidesState.checkTriggered() {
            return id.attackSidesState
        }
        return undefined
    },
}

attackSidesState = {
    id: id,
    trigger_xdist: 50,
    trigger_ydist: 30,
    finished: false,
	attack_relx: 26,
	attack_width: 30,
	attack_height: 40,
    attack_frame: 6,

    checkTriggered: function() {
        var ydist = abs(id.y - global.player.y)
        var xdist = abs(id.x - global.player.x)
        return (ydist < trigger_ydist) and (xdist < trigger_xdist)
    },
    attack: function() {
        create_enemy_attack(id.x+attack_relx, id.y, attack_width, attack_height)
        create_enemy_attack(id.x-attack_relx, id.y, attack_width, attack_height)
    },
	step: function() {
        if id.sprite_index != sKlawkin_Attack {
            if id.isAnimationEnd() {
                id.sprite_index = sKlawkin_Attack
            }
        } else {
            if id.isOnFrame(attack_frame) {
                attack()
            }
            finished = id.isAnimationEnd()
        }
    },
	onExit: function() {},
	onEnter: function() {
        finished = false
        id.image_index = 0
        id.sprite_index = sKlawkin_Charge
    },
	checkChange: function() {
        return finished ? id.wanderState : undefined
    },
}

attackUpState = {
    id: id,
    trigger_xdist: 30,
    trigger_ydist: 60,
    finished: false,
	attack_rely: -20,
	attack_width: 40,
	attack_height: 30,
    attack_frame: 6,

    checkTriggered: function() {
        var ydist = id.y - global.player.y
        var xdist = abs(id.x - global.player.x)
        return (ydist > 0 and ydist < trigger_ydist) and (xdist < trigger_xdist)
    },
    attack: function() {
        create_enemy_attack(id.x, id.y + attack_rely, attack_width, attack_height)
    },
	step: function() {
        if id.sprite_index != sKlawkin_AttackUp {
            if id.isAnimationEnd() {
                id.sprite_index = sKlawkin_AttackUp
            }
        } else {
            if id.isOnFrame(attack_frame) {
                attack()
            }
            finished = id.isAnimationEnd()
        }
    },
	onExit: function() {},
	onEnter: function() {
        finished = false
        id.image_index = 0
        id.sprite_index = sKlawkin_Charge
    },
	checkChange: function() {
        return finished ? id.wanderState : undefined
    },
}

state = wanderState

function colliding_wall(xx, yy) {
	return place_meeting(xx, yy, oWall)
}

function move(hsp, vsp) {
	return scr_move_coord_contact_obj(hsp, vsp, oWall)
}

function isAnimationEnd() {
    return is_animation_end()
}

function isOnFrame(frame) {
    return is_animation_at_frame(frame)
}

// force land him
while !move(0, 30) {}
