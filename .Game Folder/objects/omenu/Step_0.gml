/// @desc Control Menu 


animation_is_playing = instance_exists(oUnlockStageAnimation)

AnimateEaseIn()

if !has_control {
    exit
}

// keyboard Controls 
if (menu_control and !animation_is_playing) {
    var inp = oInput.key_down_pressed - oInput.key_up_pressed
    if abs(inp) {
		menu_cursor += inp
		if (menu_cursor >= menu_size) {
	      menu_cursor = 0
	    }
		if (menu_cursor < 0) {
            menu_cursor = menu_size-1
        } 
		audio_play_sound(global.sfx_nav,6,false)
    }
	if oInput.key_action {
		PerformButton(menu_cursor)
	}
}

menu_cursor = clamp(menu_cursor, 0, array_length(menu) - 1)
UpdateCursorTargetPos()
AnimateCursor()

Scroll()

if AnimationFinished() and (menu_committed != -1) {
	PerformAction()
}
