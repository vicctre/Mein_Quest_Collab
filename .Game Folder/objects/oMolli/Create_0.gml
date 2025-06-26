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
    image_speed = 1
    if isOnFrame(state.charge_pause_frame) and state.charge_pause_timer.update() {
        image_index = state.charge_pause_frame
        image_speed = 0
    }
    if isOnFrame(state.attack_frame) {
        state.attack()
        audio_play_sound(SFX_Pinch, 3, false)
    }
    if isAnimationEnd() {
        state.finished = true
    }
}

attackState = {
    id: id,
    trigger_dist: 128, //distance that activates horizontal attack
    finished: false,
	attack_relx: 26,
	attack_width: 30, //30
	attack_height: 40,//40
    attack_frame: 6,
    charge_pause_timer: make_timer(12),
    charge_pause_frame: 2,

    checkTriggered: function() {
        return inst_dist(global.player) < self.trigger_dist
    },
    attack: function() {
        create_enemy_attack(id.x+attack_relx, id.y, attack_width, attack_height)
        
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
