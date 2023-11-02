/// @desc Control Menu 

var mouse_moved = mouse_x != mouse_x_prev or mouse_y != mouse_y_prev
mouse_x_prev = mouse_x
mouse_y_prev = mouse_y

AnimateEaseIn()

//keyboard Controls 
if (menu_control) 
{
	if (keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W")) or keyboard_check_pressed(ord("Z"))) 
	{
		menu_cursor ++; 
		if (menu_cursor >= menu_items) menu_cursor = 0; 
		audio_play_sound(global.sfx_nav,6,false);
	}
}

if (menu_control) 
{
	if (keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"))) 
	{
		menu_cursor --; 
		if (menu_cursor < 0) menu_cursor = menu_items-1; 
		audio_play_sound(SFX_Menu_Nav,6,false);
	}
	
	if (keyboard_check_pressed(vk_enter) or keyboard_check_pressed(ord("X")))
	{
		PerformButton(menu_cursor)
		audio_play_sound(global.sfx_select,7,false);
	}
	var mouse_y_gui = device_mouse_y_to_gui(0); 
	if (mouse_y_gui < menu_y) && (mouse_y_gui > menu_top) //&& (mouse_x_gui > menu_x) //this only effects the buttons and doesnt make the mouse cover the full screen when selecting
	{
		if mouse_moved {
			menu_cursor = (menu_y - mouse_y_gui) div (menu_itemheight * 1.5);
		}
		
		if (mouse_check_button_pressed(mb_left))
		{
			menu_cursor = (menu_y - mouse_y_gui) div (menu_itemheight * 1.5);
			PerformButton(menu_cursor)
			audio_play_sound(global.sfx_select,7,false);
		}
		
	}

}

if AnimationFinished() and (menu_committed != -1) 
{
	menu[menu_committed].action()
	instance_destroy()
}
