
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
gp_hinp_pressed = false
gp_vinp_pressed = false
mouse_moved = false

var gp_hinp = gamepad_axis_value(0, gp_axislh)
var gp_hinp_left = gp_hinp < -gp_hinp_threshold
var gp_hinp_right = gp_hinp > gp_hinp_threshold

var gp_vinp = gamepad_axis_value(0, gp_axislv)
var gp_vinp_up = gp_vinp < -gp_vinp_threshold
var gp_vinp_down = gp_vinp > gp_vinp_threshold

key_left_pressed = keyboard_check_pressed(vk_left)
                    or keyboard_check_pressed(ord("A"))
                    or keyboard_check_pressed(ord("Q"))
                    or (gp_hinp_left && !gp_hinp_pressed_prev)
                    or gamepad_button_check_pressed(0, gp_padl)

key_right_pressed = keyboard_check_pressed(vk_right)
                    or keyboard_check_pressed(ord("D"))
                    or (gp_hinp_right && !gp_hinp_pressed_prev)
                    or gamepad_button_check_pressed(0, gp_padr)

key_up_pressed = (keyboard_check_pressed(vk_up))
                  or keyboard_check_pressed(ord("W"))
                  or keyboard_check_pressed(ord("Z"))
                  or (gp_vinp_up && !gp_vinp_pressed_prev)
                  or gamepad_button_check_pressed(0, gp_padu)
                  
key_down_pressed = (keyboard_check_pressed(vk_down))
            or keyboard_check_pressed(ord("S"))
            or (gp_vinp_down && !gp_vinp_pressed_prev)
            or gamepad_button_check_pressed(0, gp_padd)
 
key_down = (keyboard_check(vk_down))
            or keyboard_check(ord("S"))
            or (gamepad_axis_value(0, gp_axislv) > gp_vinp_threshold)
            or gamepad_button_check(0, gp_padd)
key_left = keyboard_check(vk_left)
            or keyboard_check(ord("A"))
            or gp_hinp_left
            or keyboard_check(ord("Q"))
            or gamepad_button_check(0, gp_padl)
key_right = keyboard_check(vk_right)
            or keyboard_check(ord("D")) 
            or gp_hinp_right
            or gamepad_button_check(0, gp_padr)
key_jump = keyboard_check_pressed(vk_space) or gamepad_button_check_pressed(0, gp_face1)
key_attack = keyboard_check_pressed(ord("X"))
            or keyboard_check_pressed(ord("K"))
            or (gamepad_button_check_pressed(0, gp_face3))
key_action = key_attack or keyboard_check_pressed(vk_enter)
key_escape = keyboard_check_pressed(vk_escape)
             or gamepad_button_check_pressed(0, gp_start)

key_any = keyboard_check_pressed(vk_anykey)

gp_hinp_pressed_prev = abs(gp_hinp) > gp_hinp_threshold
if (gp_hinp_pressed_prev) {
  key_left = abs(min(gp_hinp, 0))
  key_right = max(gp_hinp, 0)
}

gp_vinp_pressed_prev = abs(gp_vinp) > gp_vinp_threshold


//// Mouse
mouse_moved = mouse_x != mouse_x_prev or mouse_y != mouse_y_prev
mouse_x_prev = mouse_x
mouse_y_prev = mouse_y
