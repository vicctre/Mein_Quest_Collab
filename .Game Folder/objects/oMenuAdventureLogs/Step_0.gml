
frame++

if !has_control {
    exit
}

if oInput.key_back and mode == "grid" {
    RoomTransition(TRANS_MODE.GOTO, rmMainMenu,
                   false, 0, TRANS_TYPE.FADE)
}

var hinp = oInput.key_right_pressed - oInput.key_left_pressed
var vinp = oInput.key_down_pressed - oInput.key_up_pressed

if mode == "grid" {
	if oInput.key_action {
		mode = "read"
        with oMenuAdvLog {
            visible = true
            xto = camx_cent() + camw() * (ind - other.cursor.ind)
            x = xto
        }
        left_button.visible = true
        right_button.visible = true
		audio_play_sound(global.sfx_select, 6, false)
	}
	cursor.move(hinp, vinp)
    if abs(hinp) or abs(vinp) {
		audio_play_sound(global.sfx_nav, 6, false)
    }
} else { // mode = "read"
	if oInput.key_back {
		mode = "grid"
        with oMenuAdvLog {
            visible = false
        }
        left_button.visible = false
        right_button.visible = false
	}

	if hinp != 0 {
        if hinp > 0 {
            right_button.play_animation()
        } else {
            left_button.play_animation()
        }
		audio_play_sound(global.sfx_nav, 6, false)
        cursor.move(hinp, 0, true)
        with oMenuAdvLog {
            xto = camx_cent() + camw() * (ind - other.cursor.ind)
        }
	}
}
