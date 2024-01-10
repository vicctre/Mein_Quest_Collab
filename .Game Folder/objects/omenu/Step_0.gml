/// @desc Control Menu 

AnimateEaseIn()

// keyboard Controls 
if (menu_control) {
	if (oInput.key_up_pressed) {
		menu_cursor++; 
		if (menu_cursor >= menu_items) {
      menu_cursor = 0
    }
		audio_play_sound(global.sfx_nav,6,false)
	}
}

if (menu_control) {
	if (oInput.key_down_pressed) {
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

if AnimationFinished() and (menu_committed != -1) {
	PerformAction()
}

if oInput.key_escape and menu != main_menu {
	PerformGoBack()
	audio_play_sound(global.sfx_select,7,false)
}
