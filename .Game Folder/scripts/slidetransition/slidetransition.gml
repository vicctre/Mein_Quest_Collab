/// @desc slide transition (mode, targetroom) 
///@arg Mode sets transition mode between next, restart and goto 
///@arg target sets target room when using the goto mode 
function SlideTransition(mode, target=undefined, transition_delay=0){
	oTransition.mode = mode
	oTransition.transition_delay = transition_delay
	if target != undefined {
		oTransition.target = target	
	}
}