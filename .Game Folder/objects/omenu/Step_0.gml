/// @desc Control Menu 

AnimateEaseIn()

// keyboard Controls 
if (menu_control) {
	if (oInput.key_down_pressed) {
		menu_cursor++; 
		if (menu_cursor >= menu_items) {
	      menu_cursor = 0
	    }
		audio_play_sound(global.sfx_nav,6,false)
	}
}

if (menu_control) {
	if (oInput.key_up_pressed) {
		menu_cursor--; 
		if (menu_cursor < 0) {
      menu_cursor = menu_items-1
    } 
		audio_play_sound(SFX_Menu_Nav,6,false)
	}
	if oInput.key_action {
		PerformButton(menu_cursor)
		audio_play_sound(global.sfx_select,7,false)
	}
	var mouse_y_gui = device_mouse_y_to_gui(0); 
	// this only effects the buttons and doesnt make the mouse cover the full screen when selecting
	if (mouse_y_gui < menu_y) && (mouse_y_gui > menu_top) {
		if oInput.mouse_moved {
			menu_cursor = (menu_y - mouse_y_gui) div (menu_itemheight * 1.5)
		}

		if (mouse_check_button_pressed(mb_left)) {
			menu_cursor = (menu_y - mouse_y_gui) div (menu_itemheight * 1.5)
			PerformButton(menu_cursor)
			audio_play_sound(global.sfx_select,7,false)
		}
	}
}

menu_cursor = clamp(menu_cursor, 0, array_length(menu) - 1)

UpdateCursorTargetPos()
AnimateCursor()

/// scroll menu
menu_y_target = menu_y_base - menu_itemheight * max(0, menu_cursor - menu_y_scroll_offset)
var menu_ysp = max(menu_yspeed_min, abs(menu_y - menu_y_target) * menu_yspeed_gain)
menu_y = approach(menu_y, menu_y_target, menu_ysp)

if AnimationFinished() and (menu_committed != -1) {
	PerformAction()
}
