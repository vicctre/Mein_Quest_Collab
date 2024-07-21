event_inherited()
deadSprite = sKlawkin_Dead

wanderState = {
    id: id,
    sp: 0.5,
    dir: 1,
    attack_cooldown_timer: make_timer(90), 

	step: function() {
        id.move(sp * dir, 0)
		var check_ground_x = dir ? id.bbox_right : id.bbox_left
        if id.colliding_wall(id.x + dir, id.y)
                or !collision_point(check_ground_x, id.bbox_bottom + 1,
                                    WALLPARENT, false, false) {
            dir = -dir
        }
    },
	onExit: function() {

    },
	onEnter: function() {
        id.sprite_index = sKlawkin
        attack_cooldown_timer.reset()
    },
	checkChange: function() {
        if attack_cooldown_timer.update() {
            return undefined
        }
        if id.attackUpState.checkTriggered() {
            return id.attackUpState
        }
        if id.attackSidesState.checkTriggered() {
            return id.attackSidesState
        }
        return undefined
    },
}


function attack_step(state) {
    id.image_speed = 1
    if id.isOnFrame(state.charge_pause_frame) and state.charge_pause_timer.update() {
        id.image_index = state.charge_pause_frame
        id.image_speed = 0
    }
    if id.isOnFrame(state.attack_frame) {
        state.attack()
    }
    if id.isAnimationEnd() {
        state.finished = true
    }
}

attackSidesState = {
    id: id,
    trigger_xdist: 60, //distance that activates horizontal attack
    trigger_ydist: 40, //distance that activates upward attack
    finished: false,
	attack_relx: 26,
	attack_width: 30,
	attack_height: 40,
    attack_frame: 6,
    charge_pause_timer: make_timer(12),
    charge_pause_frame: 2,

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
		id.attack_step(self)
    },
	onExit: function() {},
	onEnter: function() {
        finished = false
        id.image_index = 0
        id.sprite_index = sKlawkin_Attack
		charge_pause_timer.reset()
    },
	checkChange: function() {
        return finished ? id.wanderState : undefined
    },
}

attackUpState = {
    id: id,
    trigger_xdist: 40,
    trigger_ydist: 65,
    finished: false,
	attack_rely: -20,
	attack_width: 40,
	attack_height: 30,
    attack_frame: 6,
    charge_pause_timer: make_timer(12),
    charge_pause_frame: 2,

    checkTriggered: function() {
        var ydist = id.y - global.player.y
        var xdist = abs(id.x - global.player.x)
        return (ydist > 0 and ydist < trigger_ydist) and (xdist < trigger_xdist)
    },
    attack: function() {
        create_enemy_attack(id.x, id.y + attack_rely, attack_width, attack_height)
    },
	step: function() {
		id.attack_step(self)
    },
	onExit: function() {},
	onEnter: function() {
        finished = false
        id.image_index = 0
        id.sprite_index = sKlawkin_AttackUp
		charge_pause_timer.reset()
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
	return move_coord_contact_obj(hsp, vsp, WALLPARENT)
}

function isAnimationEnd() {
    return is_animation_end()
}

function isOnFrame(frame) {
    return is_animation_at_frame(frame)
}


function set_hit(damage=0) {
	hp -= damage
    hit_blinking_timer.reset()
	hit_direction = sign(x-global.player.x)
    oEffects.emit_attack_contact(x, y)
}

// force land him
while !move(0, 30) {}
