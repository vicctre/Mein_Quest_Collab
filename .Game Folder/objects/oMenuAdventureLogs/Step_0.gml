
if oInput.key_escape and mode == "grid" {
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
	}
	cursor.move(hinp, vinp)
} else { // mode = "read"
	if oInput.key_escape {
		mode = "grid"
        with oMenuAdvLog {
            visible = false
        }
	}

	if hinp != 0 {
        cursor.move(hinp, 0, true)
        with oMenuAdvLog {
            xto = camx_cent() + camw() * (ind - other.cursor.ind)
        }
	}
}
