
alarm[0] = 60
log_sprite = sAdvLogMein
goto_next = false
next_room = DEMO ? rmThanksForPlayingScreen : W1_2_part1

adv_logs_to_show = oStageManager.GetNotShowedAdventureLogs()

prev_halign = draw_get_halign()
draw_set_halign(fa_middle)

current_log = instance_create_layer(1000, 0, layer, oAdvLog)
current_log.Init(array_pop(other.adv_logs_to_show))
