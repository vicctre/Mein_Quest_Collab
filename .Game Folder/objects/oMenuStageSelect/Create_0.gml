/// @desc GUI/vars/Menu Setup 

event_inherited()

button_max_size = 0

function PerformGoBack() {
	menu_committed = 0
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
		oMusic.switch_music(global.msc_stage_1_1)
		global.player_hp = global.player_hp_max
		resetable_globals()
	}
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

goback_button = {
	title: "Back",
	action: function() {
		instance_destroy(oMenuStageSelect)
		instance_create_layer(0, 0, "Instances", oMenu)
	},
}

menu = StageSelectSubmenu()

Init()
