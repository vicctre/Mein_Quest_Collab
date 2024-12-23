/// @desc GUI/vars/Menu Setup 

control_hint_text = "X/Enter/A - select"

gui_width = display_get_gui_width()
gui_height = display_get_gui_height()

non_highlight_color = c_grey

has_control = true

//// Menu positioning
menu_x_base = gui_width * 0.5
menu_x_target_start = gui_width + 300
menu_x_target_finish = menu_x_base
menu_x = menu_x_target_start
menu_x_target = menu_x_target_finish

menu_y_base = gui_height * 0.35
menu_y = menu_y_base
menu_y_target = menu_y

menu_speed = 0.1 // ease in/out speed
menu_speed_min = 1
menu_yspeed_min = 0.5 // scroll speed
menu_yspeed_gain = 0.1
menu_y_scroll_offset = 2 // scroll if menu_cursor > menu_y_scroll_offset

//// Menu control
menu_committed = -1
menu_control = true
menu_size = -1 // see below
// mouse control
menu_top = 0
menu_bottom = 0

//// Menu items size
menu_text_scale = 2
menu_itemheight = font_get_size(fntMenu) * menu_text_scale
menu_item_distance_mult = 1.5

//// Cursor positioning and drawing
menu_cursor = 0
menu_cursor_scale = menu_text_scale
menu_cursor_y = 0           // redefined below
menu_cursor_y_target = 0    //
menu_cursor_x = -10
menu_cursor_x_target = menu_cursor_x
menu_cursor_min_sp = 12
menu_cursor_frame = 0           // animate cursor
menu_cursor_animate_sp = 0.5    //

//menu_font = font_add("ka1.ttf", 24, false, false, 0, 0)
//font_add_enable_aa(false)

// buttons unlock animation
animation_is_playing = false

function GetActionInput() {
    return oInput.key_action
}

function PerformAction() {
	var menu_item = menu[menu_committed]
	if menu_item.action != undefined {
		menu_item.action()	
		instance_destroy()
		return
	}
    show_debug_message("Menu item has no action")
}

function PerformButton(index, inp) {
	menu_committed = index
	var menu_item = menu[menu_committed]
	if menu_item.action != undefined {
		menu_x_target = menu_x_target_start
		menu_control = false
		audio_play_sound(global.sfx_select, 0, false)
		return
	}
    show_debug_message("Menu item has no action")
}

function DrawTextOutlined(text, xx, yy, color, offset=2, outline_color=c_black) {
	draw_set_color(outline_color)
	draw_text_transformed(xx - offset, yy, text, menu_text_scale, menu_text_scale, 0)
	draw_text_transformed(xx + offset, yy, text, menu_text_scale, menu_text_scale, 0)
	draw_text_transformed(xx, yy - offset, text, menu_text_scale, menu_text_scale, 0)
	draw_text_transformed(xx, yy + offset, text, menu_text_scale, menu_text_scale, 0)
	draw_set_color(color)
	draw_text_transformed(xx, yy, text, menu_text_scale, menu_text_scale, 0)
}

function AnimateEaseIn() {
	var diff = abs(menu_x_target - menu_x)
	var sp = max(menu_speed_min, diff * menu_speed)
	menu_x += sp * sign(menu_x_target - menu_x)
	if diff < menu_speed_min {
		menu_x = menu_x_target
	}
}

// Ease in finished
function AnimationFinished() {
	return abs(menu_x - menu_x_target_start) < menu_speed_min
}

function Scroll() {
    // offset to move menu by
    var offset = max(0, menu_cursor - menu_y_scroll_offset)
    menu_y_target = menu_y_base - menu_itemheight*offset*menu_item_distance_mult
    var menu_ysp = max(menu_yspeed_min, abs(menu_y - menu_y_target) * menu_yspeed_gain)
    menu_y = approach(menu_y, menu_y_target, menu_ysp)
}
 
function UpdateMenuBounds() {
	menu_top = GetCursorY(0)
    menu_bottom = GetCursorY(menu_size)
}

function GetCursorY(cursor) {
	return menu_y + ((menu_itemheight * 1.5) * cursor)
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

    if object_index == oMenu {
        var test = true
    }
    if object_index == oMenuStageSelect {
        var test = true
    }
}

function DrawHintText() {
    draw_set_color(non_highlight_color)
    draw_set_halign(fa_left)
    var fnt = draw_get_font()
    draw_set_font(Font01)
    draw_text_transformed(
                gui_width * 0.05,   // = x
                gui_height * 0.8,   // = y
                control_hint_text,
                0.75, 0.75, 0)
    draw_set_color(c_white)
    draw_set_font(fnt)
}

menu = [
	{
		title: "Stage select",
		action: function() {
			instance_destroy(oMenu)
			instance_create_layer(0, 0, "Instances", oMenuStageSelect)
		}
	},
	{
		title: "Adventure Logs",
		action: function() {
            RoomTransition(TRANS_MODE.GOTO, rmMenuAdventureLogsScreen,
                           false, 0, TRANS_TYPE.FADE)
        }
	},
	{
		title: "Options",
		action: function() {
			instance_destroy(oMenu)
			instance_create_layer(0, 0, "Instances", oMenuOptions)
		}
	},
	{
		title: "Quit",
		action: game_end
	}
]
menu_size = array_length(menu)

UpdateMenuBounds()

//// go to stage select if just beated a stage
if global.goto_stage_select {
	global.goto_stage_select = false
	menu[0].action()
}



menu_cursor_y = GetCursorY(0)
menu_cursor_y_target = menu_cursor_y
