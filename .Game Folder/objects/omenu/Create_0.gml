/// @desc GUI/vars/Menu Setup 

#macro SAVEFILE "Save.sav" 

gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
gui_margin = 36; 

menu_x_target_start = gui_width + 200;
menu_x_target_finish = menu_x_target_start - 50
menu_x = menu_x_target_start
menu_y = gui_height - gui_margin; 
menu_x_target = gui_width - gui_margin; 
menu_speed = 0.05;
//menu_font = fMenu; 
menu_itemheight = font_get_size(fMenu); 
menu_committed = -1; 
menu_control = true;

x_ancor = fa_right
y_ancor = fa_bottom

mouse_x_prev = mouse_x
mouse_y_prev = mouse_y

function PerformButton(index) {
	menu_committed = index
	menu_x_target = menu_x_target_start
	menu_control = false
}

function StartNew() {
	if room == MenuTitleScreenV1 {
		oMusic.switch_music(noone)
	}
	SlideTransition(TRANS_MODE.GOTO, rmIntroSequence);
	global.player_hp = global.player_hp_max
}

function AnimateEaseIn() {
	menu_x += (menu_x_target - menu_x) * menu_speed; 
}

function AnimationFinished() {
	return menu_x > menu_x_target_finish
}

function Highlight(txt) {
	return string_insert("> ", txt,0);
}

function UpdateTop() {
	menu_top = menu_y - ((menu_itemheight * 1.5) * menu_items)
}

function Init() {
	menu_items = array_length(menu)
	menu_cursor = menu_items - 1
	UpdateTop()
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
				oMusic.switch_music(global.msc_stage_1_1)
			}
		}
	},
	{
		//title: "New Game",
		title: "Start",
		action: oMenu.StartNew
	},
]

Init()
