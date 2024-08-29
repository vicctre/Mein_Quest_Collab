/// @desc GUI/vars/Menu Setup 

event_inherited()

menu_text_scale = 1
menu_cursor_scale = 2
icon_scale = 2

menu_itemheight = font_get_size(fMenu) * icon_scale + 24
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

function PerformGoBack() {
	menu_committed = array_length(menu) - 1
	menu_x_target = menu_x_target_start
	menu_control = false
}

function StageButton(ind, stage, title, spr, stage_locked=false) constructor {
    self.parent = oMenuStageSelect
    self.ind = ind
	self.stage = stage
	self.title = title
	self.sprite = spr
	self.stage_locked = stage_locked

	function action() {
		if stage_locked {
			return;
		}
		if stage == W1_1_part1 {
			RoomTransition(TRANS_MODE.GOTO, rmIntroSequence)
		} else {
			RoomTransition(TRANS_MODE.GOTO, stage)
		}
		global.player_hp = global.player_hp_max
		game_reset_globals()
	}

    function getx() {
        return parent.menu_x
    }

    function gety() {
        return parent.menu_y + (parent.menu_itemheight * (ind * parent.menu_item_distance_mult))
    }

    function get_text_x() {
        return getx() - parent.icon_half_width * 0.9
    }
    
    function draw() {
        // draw icon
        if sprite {
            draw_sprite_ext(sprite, 0, getx(), gety(),
                parent.icon_scale, parent.icon_scale,
                0, c_white, 1)
        }
        // draw text in icon's left small window
        var col = parent.menu_cursor == ind ? c_white : c_grey
        parent.DrawTextOutlined(title, get_text_x(), gety(), col)
    }

    function play_unlock_animation() {
        with instance_create_layer(getx(), gety(), "UnlockAnimations", oUnlockStageAnimation) {
            follow = other
            image_xscale = other.parent.icon_scale
            image_yscale = other.parent.icon_scale
        }
    }
}

//function UpdateCursorTargetPos() {
//	menu_cursor_y_target = GetCursorY(menu_cursor)
//	menu_cursor_x_target = menu_x - icon_half_width
//}

function UpdateCursorTargetPos() {
	menu_cursor_y_target = GetCursorY(menu_cursor)
	menu_cursor_x_target = (gui_width - menu_x) - icon_half_width - 20
}

function StageSelectmenu() {
	var menu = [
		new StageButton(0, W1_1_part1, "1-1", sStage1_1Icon),
		new StageButton(1, W1_2_part1, "1-2", sStage1_2Icon),
		new StageButton(2, W1_3_part1, "1-3", sStage1_3Icon),
		// new StageButton(W1_3_part1, "2-1", sStageLockIcon, true),
	]
	
	for(var i=0; i<array_length(menu); i++) {
		var btn = menu[i]
		if oStageManager.IsStageUnlocked(btn.stage) {
            if !oStageManager.StageUnlockAnimationPlayed(btn.stage) {
                // btn.stage_locked = false
                oStageManager.SetUnlockAnimationPlayed(btn.stage)
                menu[i].play_unlock_animation()
            }
        } else {
			btn.sprite = sStageLockIcon
			btn.stage_locked = true
		}
	}
    
    goback_button = new StageButton(3, noone, "Back")
    goback_button.action = function() {
        instance_destroy(oMenuStageSelect)
        instance_create_layer(0, 0, "Instances", oMenu)
    }
	array_push(menu, goback_button)
	return menu
}

function IsStageLocked(index) {
	return menu[index].stage and menu[index].stage_locked
}

function PerformButton(index) {
	if IsStageLocked(index) {
		audio_play_sound(global.sfx_not_available, 7, false)
		return;
	}
	menu_committed = index
	menu_x_target = menu_x_target_start
	menu_control = false
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

menu = StageSelectmenu()
menu_size = array_length(menu)

UpdateMenuBounds()

//// Unlock pogo after defeating Rula
if global.player_pogo_just_unlocked {
    oStageManager.UnlockPogoAttack()
    oUIPopUpMessage.PopUp("You've unlocked stage two!")
    oUIPopUpMessage.PopUp("You've unlocked pogo attack!")
    global.player_pogo_just_unlocked = false
}
