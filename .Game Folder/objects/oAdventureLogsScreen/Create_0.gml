
alarm[0] = 60
goto_next = false

adv_logs_to_show = oStageManager.GetNotShowedAdventureLogs()
if array_length(adv_logs_to_show) == 0 {
    if DEMO and global.room_prev == W1_3BOSS {
        RoomTransition(TRANS_MODE.GOTO, rmThanksForPlayingScreen)
    } else {
        GoToStageSelect()
    }
	exit
}
for(var i = 0; i < array_length(adv_logs_to_show); ++i) {
	oStageManager.SetAdvLogShown(adv_logs_to_show[i])
}

prev_halign = draw_get_halign()
draw_set_halign(fa_middle)

current_log = instance_create_layer(1000, 0, layer, oAdvLog)
current_log.Init(array_pop(other.adv_logs_to_show))

// save unlocked adv logs only when reached AdvLog screen
oStageManager.Save()
