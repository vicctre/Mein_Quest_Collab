
var music = noone

if IsStageRoom(room)
	music = global.msc_stage_1_1

switch room {
	case W1_1_part5:
		music = global.msc_miniboss
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
	case BGM_Thanks_for_playing:
		music = global.msc_adv_log_screen
		break
}

if music and music != oMusic.CurrentMusic() {
	oMusic.switch_music(music)
}
