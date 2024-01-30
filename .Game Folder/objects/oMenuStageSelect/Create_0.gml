/// @desc GUI/vars/Menu Setup 

event_inherited()

menu_text_scale = 1
menu_cursor_scale = 2
icon_scale = 2

menu_itemheight = font_get_size(fMenu) * icon_scale + 8
icon_half_width = sprite_get_width(sStage1_1Icon) * icon_scale * 0.5


function PerformGoBack() {
	menu_committed = array_length(menu) - 1
	menu_x_target = menu_x_target_start
	menu_control = false
}

function StageStarter(stage, title, spr, stage_locked=false) constructor {
	self.stage = stage
	self.title = title
	self.sprite = spr
	self.stage_locked = stage_locked

	function action() {
		if stage_locked {
			return;
		}
		if stage == W1_1_part1 {
			SlideTransition(TRANS_MODE.GOTO, rmIntroSequence)
		} else {
			SlideTransition(TRANS_MODE.GOTO, stage)
		}
		global.player_hp = global.player_hp_max
		game_reset_globals()
	}
}

function UpdateCursorTargetPos() {
	menu_cursor_y_target = GetCursorY(menu_cursor)
	menu_cursor_x_target = menu_x - icon_half_width
}

function StageSelectmenu() {
	var menu = [
		new oMenu.StageStarter(W1_1_part1, "1-1", sStage1_1Icon),
		new oMenu.StageStarter(W1_2_part1, "1-2", sStage1_2Icon),
		new oMenu.StageStarter(W1_3_part1, "1-3", sStage1_3Icon),
		//new oMenu.StageStarter(W1_3_part1, "2-1", sStageLockIcon, true),
	]
	
	for(var i=0; i<array_length(menu); i++) {
		var btn = menu[i]
		if !oStageManager.IsStageUnlocked(btn.stage) {
			btn.sprite = sStageLockIcon
			btn.stage_locked = true
		}
	}
	array_push(menu, goback_button)
	return menu
}

function IsStageLocked(index) {
	return menu[index].stage and menu[index].stage_locked
}

function PerformButton(index) {
	if IsStageLocked(index) {
		return;
	}
	menu_committed = index
	menu_x_target = menu_x_target_start
	menu_control = false
}

goback_button = {
	title: "Back",
	sprite: undefined,
	stage: undefined,
	action: function() {
		instance_destroy(oMenuStageSelect)
		instance_create_layer(0, 0, "Instances", oMenu)
	},
}

menu = StageSelectmenu()
menu_size = array_length(menu)

UpdateMenuBounds()
