
ensure_singleton()

key_left_pressed = false
key_right_pressed = false
key_up_pressed = false
key_down_pressed = false
key_down = false
key_left = false
key_right = false
key_jump = false
key_attack = false
key_any = false
key_restart = false
gp_hinp_pressed = false
gp_vinp_pressed = false

gp_hinp_threshold = 0.25
gp_vinp_threshold = 0.85

//// Mouse
mouse_moved = false
mouse_x_prev = mouse_x
mouse_y_prev = mouse_y

active = true

function SetActive() {
    active = true
}

function SetInactive() {
    active = false
}