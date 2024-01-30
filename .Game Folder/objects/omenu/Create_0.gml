/// @desc GUI/vars/Menu Setup 

#macro SAVEFILE "Save.sav" 

gui_width = display_get_gui_width()
gui_height = display_get_gui_height()
gui_margin = 36

menu_x_base = gui_width * 0.5
menu_x_target_start = gui_width + 200
menu_x_target_finish = menu_x_base
menu_x = menu_x_target_start
menu_y = gui_height * 0.35
menu_y_base = menu_y
menu_y_target = menu_y
menu_x_target = menu_x_target_finish
menu_speed = 0.1
menu_speed_min = 1
menu_yspeed_gain = 0.1
menu_yspeed_min = 0.5
//menu_font = fMenu
menu_text_scale = 2
menu_itemheight = font_get_size(fMenu) * menu_text_scale
menu_item_distance_mult = 1.5
menu_committed = -1
menu_control = true
menu_y_scroll_offset = 2

menu_cursor_scale = menu_text_scale
menu_cursor_y = 0

menu_cursor_y_shift = -32 * 0 * menu_text_scale // -32 was figured experimentally (smth like half of font height)
menu_cursor_y_min = 100
menu_cursor_y_max = gui_height - 100
menu_cursor_x_target = menu_x_base
menu_cursor_x = menu_x_base
menu_cursor_y_target = 0
menu_cursor_min_sp = 12
menu_cursor_frame = 0
menu_cursor_animate_sp = 0.5

menu_top = 0 // used for mouse control
mouse_x_prev = mouse_x
mouse_y_prev = mouse_y

function DrawTextOutlined(text, xx, yy, color, offset=2, outline_color=c_black) {
	draw_set_color(outline_color)
	draw_text_transformed(xx - offset, yy, text, menu_text_scale, menu_text_scale, 0)
	draw_text_transformed(xx + offset, yy, text, menu_text_scale, menu_text_scale, 0)
	draw_text_transformed(xx, yy - offset, text, menu_text_scale, menu_text_scale, 0)
	draw_text_transformed(xx, yy + offset, text, menu_text_scale, menu_text_scale, 0)
	draw_set_color(color)
	draw_text_transformed(xx, yy, text, menu_text_scale, menu_text_scale, 0)
}

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

function StageStarter(stage, title) constructor {
	self.stage = stage
	self.title = title
	self.sprite = sMenuStageIcon

	function action() {
		if stage == W1_1_part1 {
			SlideTransition(TRANS_MODE.GOTO, rmIntroSequence)
		} else {
			SlideTransition(TRANS_MODE.GOTO, stage)
		}
		global.player_hp = global.player_hp_max
		game_reset_globals()
	}
}

function StartNew() {
	if room == rmTitleScreen {
		oMusic.switch_music(noone)
	}
	SlideTransition(TRANS_MODE.GOTO, rmIntroSequence)
	global.player_hp = global.player_hp_max
	game_reset_globals()
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

function UpdateCursorTargetPos() {
	menu_cursor_y_target = GetCursorY(menu_cursor)
	var string_half_width = string_width(menu[menu_cursor].title) * menu_text_scale * 0.5
	menu_cursor_x_target = (gui_width - menu_x) - string_half_width - 20
}

function AnimateCursor() {
	var dir = point_direction(
				menu_cursor_x, menu_cursor_y,
				menu_cursor_x_target, menu_cursor_y_target)
	var dist = point_distance(
				menu_cursor_x, menu_cursor_y,
				menu_cursor_x_target, menu_cursor_y_target)
	var sp = max(menu_speed * dist, menu_cursor_min_sp)
	var hsp = abs(lengthdir_x(sp, dir))
	var vsp = abs(lengthdir_y(sp, dir))
	menu_cursor_x = approach(menu_cursor_x, menu_cursor_x_target, hsp)
	menu_cursor_y = approach(menu_cursor_y, menu_cursor_y_target, vsp)
	menu_cursor_frame += menu_cursor_animate_sp
}
 
function UpdateTop() {
	menu_top = GetCursorY(menu_items)
}

function GetCursorY(cursor) {
	return menu_y + ((menu_itemheight * 1.5) * cursor) + menu_cursor_y_shift
}

function Init() {
	menu_items = array_length(menu)
	menu_cursor = 0
	menu_cursor_y_target = GetCursorY(menu_cursor)
	menu_cursor_y = menu_cursor_y_target
	UpdateTop()
}

main_menu = [
	{
		//title: "New Game",
		title: "Stage select",
		action: function() {
			instance_destroy(oMenu)
			instance_create_layer(0, 0, "Instances", oMenuStageSelect)
		}
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
			}
		}
	},
	{
		title: "Quit",
		action: game_end
	}
]

menu = main_menu

Init()
