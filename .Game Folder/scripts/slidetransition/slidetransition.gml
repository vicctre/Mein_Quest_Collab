/// @desc slide transition (mode, targetroom) 
///@arg Mode sets transition mode between next, restart and goto 
///@arg target sets target room when using the goto mode 

function RoomTransition(
        mode_, target=undefined, stage_win=false,
        transition_delay=0, type=TRANS_TYPE.SLIDE) {
    with oTransition {
        mode = mode_
        is_forward = true
        is_on = true
        transition_delay = transition_delay
        trans_type = type
        if target != undefined {
            oTransition.target = target	
        }
    }
	if stage_win {
		oEventSystem.Notify(Events.stage_win)
	}
}

function GoToStageSelect() {
	global.goto_stage_select = true
	RoomTransition(TRANS_MODE.GOTO, rmMainMenu)
}
