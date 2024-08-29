/// @desc Control Menu 

AnimateEaseIn()

// keyboard Controls 
if (menu_control) {
	if (oInput.key_down_pressed) {
		menu_cursor++; 
		if (menu_cursor >= menu_size) {
	      menu_cursor = 0
	    }
		audio_play_sound(global.sfx_nav,6,false)
	}
}

if (menu_control) {
	if (oInput.key_up_pressed) {
		menu_cursor--; 
		if (menu_cursor < 0) {
            menu_cursor = menu_size-1
        } 
		audio_play_sound(global.sfx_nav,6,false)
	}
	if oInput.key_action {
		PerformButton(menu_cursor)
	}
	// var mouse_y_gui = device_mouse_y_to_gui(0); 
	// this only effects the buttons and doesnt make the mouse cover the full screen when selecting
	// if (mouse_y_gui < menu_bottom) && (mouse_y_gui > menu_top) {
	// 	if oInput.mouse_moved {
    //         var h = menu_itemheight * menu_item_distance_mult
	// 		menu_cursor = (mouse_y_gui - menu_top + h*0.5) div h
	// 	}

	// 	if (mouse_check_button_pressed(mb_left)) {
	// 		PerformButton(menu_cursor)
	// 	}
	// }
}

menu_cursor = clamp(menu_cursor, 0, array_length(menu) - 1)
UpdateCursorTargetPos()
AnimateCursor()

Scroll()

if AnimationFinished() and (menu_committed != -1) {
	PerformAction()
}
