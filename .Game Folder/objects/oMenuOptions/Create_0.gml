/// @desc GUI/vars/Menu Setup 

event_inherited()

control_hint_text = "X/Enter/A - select\nEsc/Back - go back\nLeft/Right - adjust"

menu_text_scale = 2
menu_text_relx = -60
menu_cursor_scale = 2
icon_scale = 2

menu_itemheight = font_get_size(fntMenu) * icon_scale + 24
icon_half_width = sprite_get_width(sStage1_1Icon) * icon_scale * 0.5

// adventure logs
adv_log_x_base = 58 * icon_scale
adv_log_y_base = 0
adv_log_width = sprite_get_width(sStageIconAdvLog) * icon_scale
adv_log_gap = 3 * icon_scale
adv_log_step = adv_log_width + adv_log_gap
// animation
adv_log_play_animation_index = -1
adv_log_play_animation_frames = 0
adv_log_play_animation_sp = sprite_get_speed(sAdvLogIconAnimation) / game_get_speed(gamespeed_fps)
menu_cursor_prev = -1

// distance between text and input
inputs_padding = 30

enum OptionInputType {
    checkbox,
    slider
}

enum OptionInputAction {
    click = 1,
    decrease,
    increase,
}

function PerformGoBack() {
	menu_committed = array_length(menu) - 1
	menu_x_target = menu_x_target_start
	menu_control = false
}

function OptionInput(ind, type, title, key, value) constructor {
    self.parent = oMenuOptions
    self.ind = ind
    self.type = type
	self.title = title
    self.key = key
    self.value = value

    function getx() {
        return parent.menu_x
    }

    function gety() {
        return parent.menu_y + (parent.menu_itemheight * (ind * parent.menu_item_distance_mult))
    }

    function get_text_x() {
        return getx() + parent.menu_text_relx
    }

    self.draw = function() {
        var col = parent.menu_cursor == ind ? c_white : c_grey
        draw_set_halign(fa_right)
        parent.DrawTextOutlined(title, get_text_x(), gety(), col)
        draw_input()
    }

    self.draw_input = function() {}

	switch self.type {
        case OptionInputType.checkbox:
            self.action = function() {
                self.value = !self.value
                oStageManager.OptionsUpdate(key, value)
            }
            self.draw_input = function () {
                draw_set_halign(fa_left)
                parent.DrawTextOutlined(
                    self.value ? "On" : "Off",
                    getx() + oMenuOptions.inputs_padding,
                    gety(), c_white)
            }
        break
        case OptionInputType.slider:
            var scale = oMenuOptions.icon_scale
            self.slider = new UiSlider(
                sOption_Slider, 1, value, 0, 1, 9, scale, scale, false, 0)
            self.action = function(inp) {
                self.value = clamp(self.value + inp * 0.1, 0, 1)
                self.slider.set_value(self.value)
                oStageManager.OptionsUpdate(key, value)
            }
            self.draw_input = function() {
                var col = parent.menu_cursor == ind ? c_white : c_grey
                parent.DrawTextOutlined(title, get_text_x(), gety(), col)
    
                /// Draw slider
                var scale = oMenuOptions.icon_scale
                var yy = gety() - sprite_get_height(sOption_Slider) * scale * 0.5
                var xx = getx() + oMenuOptions.inputs_padding
                self.slider.set_pos(xx, yy)
                self.slider.draw()
            }
        break
		default:
			self.action = function() {}
    } 
}

function UpdateCursorTargetPos() {
	menu_cursor_y_target = GetCursorY(menu_cursor)
	var w = string_width(menu[menu_cursor].title) * menu_text_scale
	menu_cursor_x_target = (gui_width - menu_x) - w - 60
}

function OptionsMenu() {
	var menu = [
		new OptionInput(0, OptionInputType.slider, "SFX", "sfx", oStageManager.game_options.sfx),
		new OptionInput(1, OptionInputType.slider, "Music", "music", oStageManager.game_options.music),
		new OptionInput(2, OptionInputType.checkbox, "Tutorials", "tutorials", oStageManager.game_options.tutorials),
	]

    goback_button = new OptionInput(3, undefined, "Back")
    goback_button.action = function() {
        instance_destroy(oMenuOptions)
        instance_create_layer(0, 0, "Instances", oMenu)
    }
	array_push(menu, goback_button)
	return menu
}

function GetActionInput() {
    if oInput.key_action {
        return OptionInputAction.click
    }
    if oInput.key_left_pressed {
        return OptionInputAction.decrease
    }
    if oInput.key_right_pressed {
        return OptionInputAction.increase
    }
	return 0
}

function PerformButton(index, inp) {
    var menu_input = menu[index]
    switch menu_input.type {
        case OptionInputType.slider:
            inp = (inp == OptionInputAction.increase)
                    - (inp == OptionInputAction.decrease)
            menu_input.action(inp)
        break
        case OptionInputType.checkbox:
            if inp == OptionInputAction.click {
                menu_input.action()
            }
        break
        default:
            // go back
            menu_input.action()
    }
	audio_play_sound(global.sfx_select, 7, false)
}

function DrawAdvLogs(stage, icon_x, icon_y, animate) {
	var logs = oStageManager.GetStageData(stage)
	if logs == undefined {
		return;
	}
	logs = logs.adv_logs
	var count = variable_struct_names_count(logs)
	var between_first_and_last = (adv_log_width + adv_log_gap) * (count - 1)
	var xst = icon_x + adv_log_x_base - between_first_and_last * 0.5

	// form of ordered names to draw properly
	var ordered_names = oStageManager.GetStageAdvLogNames(stage)

	// draw
	for (var i = 0; i < count; ++i) {
		// get sprite depending on if advlog is unlocked
		var spr = logs[$ ordered_names[i]].unlocked ? sAdvLogIconAnimation : sStageIconAdvLogLocked
		draw_sprite_ext(spr, animate ? adv_log_play_animation_frames : 0,
			            xst + adv_log_step * i,
						icon_y + adv_log_y_base,
						icon_scale, icon_scale,
						0, c_white, 1)
	}
}

menu = OptionsMenu()
menu_size = array_length(menu)

UpdateMenuBounds()

//// Unlock pogo after defeating Rula
if global.player_pogo_just_unlocked {
    oStageManager.UnlockPogoAttack()
    oUIPopUpMessage.PopUp("Hey there, since the wait for Demo 2 was quite some time, we wanted to give you one more thing to do! The first stage of World 2 has been unlocked, give it a go if you want to see more")
    oUIPopUpMessage.PopUp("The Sister Spirit has granted you a new ability: The Pogo Attack! Press down and attack midair to bounce off enemies and objects. This can be used in previous stages too, have fun! ")
    global.player_pogo_just_unlocked = false
}
