/// @desc Control Menu 

//Item Ease in 
menu_x += (menu_x_target - menu_x) / menu_speed; 

//keyboard Controls 
if (menu_control) 
{
	if (keyboard_check_pressed(vk_up)) 
	{
		menu_cursor ++; 
		if (menu_cursor >= menu_items) menu_cursor = 0; 
		audio_play_sound(SFX_Menu_Nav,6,false);
	}

}

if (menu_control) 
{
	if (keyboard_check_pressed(vk_down)) 
	{
		menu_cursor --; 
		if (menu_cursor < 0) menu_cursor = menu_items-1; 
		audio_play_sound(SFX_Menu_Nav,6,false);
	}
	
	if (keyboard_check_pressed(vk_enter)) 
	{
		menu_x_target = gui_width+200; 
		menu_committed = menu_cursor; 
		menu_control = false 
		audio_play_sound(SFX_Menu_select,7,false);
	}
	var mouse_y_gui = device_mouse_y_to_gui(0); 
	if (mouse_y_gui < menu_y) && (mouse_y_gui > menu_top) //&& (mouse_x_gui > menu_x) //this only effects the buttons and doesnt make the mouse cover the full screen when selecting
	{
		menu_cursor = (menu_y - mouse_y_gui) div (menu_itemheight * 1.5);
		
		if (mouse_check_button_pressed(mb_left))
		{
			menu_x_target = gui_width+200; 
			menu_committed = menu_cursor; 
			menu_control = false 
			audio_play_sound(SFX_Menu_select,7,false);
		}
		
	}

}

if (menu_x > gui_width+150) and (menu_committed != -1) 
{
	switch (menu_committed) 
	{
		case 2: SlideTransition(TRANS_MODE.NEXT); break; 
		case 1: 
		{
			if (!file_exists(SAVEFILE)) 
			{
				SlideTransition(TRANS_MODE.NEXT);
			}
			else 
			{
				var file = file_text_open_read(SAVEFILE); 
				var target = file_text_read_real(file); 
				file_text_close(file); 
				SlideTransition(TRANS_MODE.GOTO,target); 
			}
		}
		break; 
		case 0: game_end(); break
	}
}