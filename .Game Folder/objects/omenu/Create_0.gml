/// @desc GUI/vars/Menu Setup 

#macro SAVEFILE "Save.sav" 

gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
gui_margin = 32; 

menu_x = gui_width + 200; 
menu_y = gui_height - gui_margin; 
menu_x_target = gui_width - gui_margin; 
menu_speed = 20; //lower is faster
//menu_font = fMenu; 
menu_itemheight = font_get_size(fMenu); 
menu_committed = -1; 
menu_control = true;

function PerformButton(index) {
	menu_committed = index
	menu_x_target = gui_width+200;
	menu_control = false
}

function StartNew() {
	SlideTransition(TRANS_MODE.NEXT)
	global.player_hp = global.player_hp_max
}

menu = [
	{
		title: "Quit",
		action: game_end
	},
	{
		title: "Continue",
		action: function() {
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
	},
	{
		title: "New Game",
		action: oMenu.StartNew
	},
]

menu_items = array_length(menu); 
menu_top = menu_y - ((menu_itemheight * 1.5) * menu_items); 
menu_cursor = menu_items - 1;

global.coins = 0;
