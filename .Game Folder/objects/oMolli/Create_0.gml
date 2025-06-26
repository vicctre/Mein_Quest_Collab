event_inherited()
deadSprite = sMolli_D

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
            id.image_xscale = dir
        }
    },
	onExit: function() {

    },
	onEnter: function() {
        id.sprite_index = sMolli
        attack_cooldown_timer.reset()
    },
	checkChange: function() {
        if attack_cooldown_timer.update() {
            return undefined
        }
        if id.attackState.checkTriggered() {
            return id.attackState
        }
        return undefined
    },
}

attackState = {
    id: id,
    trigger_dist: 128, //distance that activates horizontal attack
    finished: false,
	attack_relx: -10,
    attack_rely: -10,
	attack_width: 60, //30
	attack_height: 40,//40

    checkTriggered: function() {
        return inst_dist(global.player) < self.trigger_dist
    },
    attack: function() {
        with create_enemy_attack(
            id.x+attack_relx*id.image_xscale, id.y+attack_rely,
            attack_width, attack_height) {
            alarm[0] = 10
        }
        with id {
            var zap_platform = instance_place(x, y+1, oZapPlatform)
            if zap_platform != noone {
                zap_platform.Zap()
            }
        }
    },
	step: function() {
        with id {
            if isAnimationEnd() {
                if sprite_index == sMolli_Attack_Prep {
                    other.attack()
                    sprite_index = sMolli_Attack
                } else {
                    other.finished = true
                }
            }
        }
    },
	onExit: function() {},
	onEnter: function() {
        finished = false
        id.sprite_index = sMolli_Attack_Prep
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
