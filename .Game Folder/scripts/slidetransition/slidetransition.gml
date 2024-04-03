/// @desc slide transition (mode, targetroom) 
///@arg Mode sets transition mode between next, restart and goto 
///@arg target sets target room when using the goto mode 

function SlideTransition(mode, target=undefined, stage_win=false, transition_delay=0){
	oTransition.mode = mode
	oTransition.transition_delay = transition_delay
	if target != undefined {
		oTransition.target = target	
	}
	if stage_win {
		oEventSystem.Notify(Events.stage_win)
	}
}

function GoToStageSelect() {
	global.goto_stage_select = true
	SlideTransition(TRANS_MODE.GOTO, rmMainMenu)
}
