
var music = undefined
var room_prefix = string_copy(room_get_name(room), 0, 4)

switch room_prefix {
	case "W1_1":
		music = global.msc_stage1_1
	break
	case "W1_2":
		music = global.msc_stage1_2
	break
}

// special cases
switch room {
	case W1_1_part5:
		music = global.msc_miniboss
		break
	case W1_2_part5_AutoScroller2:
		music = global.msc_stage1_2_2
		break
	case W1_3_part1:
		music = global.msc_pre_rularog
		break
	case W1_3BOSS:
		music = noone
		break
	case rmTitleScreen:
		music = global.msc_title_screen
		break
	case rmMainMenu:
		music = global.msc_main_menu
		break
	case rmIntroSequence:
		music = global.msc_intro
		break
	case rmAdventureLogsScreen:
		music = global.msc_adv_log_screen
		break
}

if music != undefined and music != oMusic.CurrentMusic() {
	oMusic.switch_music(music)
}
