/// @desc GUI/vars/Menu Setup 

#macro SAVEFILE "Save.sav" 

gui_width = display_get_gui_width()
gui_height = display_get_gui_height()
gui_margin = 36

menu_x_target_start = gui_width + 200
menu_x_target_finish = gui_width - gui_margin
menu_x = menu_x_target_start
menu_y = gui_height - gui_margin
menu_x_target = menu_x_target_finish
menu_speed = 0.1
menu_speed_min = 1
//menu_font = fMenu
menu_itemheight = font_get_size(fMenu)
menu_committed = -1
menu_control = true

x_ancor = fa_right
y_ancor = fa_bottom

mouse_x_prev = mouse_x
mouse_y_prev = mouse_y

gp_vinp_threshold = 0.85
gp_vinp_pressed = false

function PerformAction() {
	var menu_item = menu[menu_committed]
	if menu_item.action != undefined {
		menu_item.action()	
		instance_destroy()
		return
	}
	if menu_item.submenu != undefined {
		menu = menu_item.submenu()
		menu_x_target = menu_x_target_finish
		menu_committed = -1
		menu_control = true
		Init()
	}
}

function PerformButton(index) {
	menu_committed = index
	menu_x_target = menu_x_target_start
	menu_control = false
}

function PerformGoBack() {
	menu_committed = 0
	menu_x_target = menu_x_target_start
	menu_control = false
}

function StageStarter(stage, title) constructor {
	self.stage = stage
	self.title = title
	
	function action() {
		if room == MenuTitleScreenV1 {
			oMusic.switch_music(noone)
		}
		if stage == W1_1_part1 {
			SlideTransition(TRANS_MODE.GOTO, rmIntroSequence)
		} else {
			SlideTransition(TRANS_MODE.GOTO, stage)
		}
		global.player_hp = global.player_hp_max
		resetable_globals()
	}
}

function StartNew() {
	if room == MenuTitleScreenV1 {
		oMusic.switch_music(noone)
	}
	SlideTransition(TRANS_MODE.GOTO, rmIntroSequence)
	global.player_hp = global.player_hp_max
	resetable_globals()
}

function StageSelectSubmenu() {
	var submenu = []
	array_push(submenu, goback_button)
	for(var i=0; i<array_length(global.available_stages); i++) {
		var stage = global.available_stages[i]
		var starter = new oMenu.StageStarter(stage, room_get_name(stage))
		array_push(submenu, starter)
	}
	return submenu
}

function AnimateEaseIn() {
	var diff = abs(menu_x_target - menu_x)
	var sp = max(menu_speed_min, diff * menu_speed)
	menu_x += sp * sign(menu_x_target - menu_x)
	if diff < menu_speed_min {
		menu_x = menu_x_target
	}
}

function AnimationFinished() {
	return abs(menu_x - menu_x_target_start) < menu_speed_min
}

function Highlight(txt) {
	return string_insert("> ", txt,0)
}

function UpdateTop() {
	menu_top = menu_y - ((menu_itemheight * 1.5) * menu_items)
}

function Init() {
	menu_items = array_length(menu)
	menu_cursor = menu_items - 1
	UpdateTop()
}

main_menu = [
	{
		title: "Quit",
		action: game_end
	},
	{
		title: "Continue",
		action: function() {
			if (!file_exists(SAVEFILE)) 
			{
				SlideTransition(TRANS_MODE.NEXT)
			}
			else 
			{
				var file = file_text_open_read(SAVEFILE) 
				var target = file_text_read_real(file) 
				file_text_close(file) 
				SlideTransition(TRANS_MODE.GOTO,target)
				oMusic.switch_music(global.msc_stage_1_1)
			}
		}
	},
	{
		//title: "New Game",
		title: "Stage select",
		action: undefined,
		submenu: oMenu.StageSelectSubmenu
	},
]

goback_button = {
	title: "Back",
	action: undefined,
	submenu: function() {
		return oMenu.main_menu
	}
}

menu = main_menu

Init()
