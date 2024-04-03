
if goto_next and oInput.key_action {
    if array_length(adv_logs_to_show) {
		current_log.EaseOut()
		current_log = instance_create_layer(1000, 0, layer, oAdvLog)
		current_log.Init(array_pop(other.adv_logs_to_show))
		goto_next = false
		alarm[0] = 60
    } else {
        GoToStageSelect()
    }
}
