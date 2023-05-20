/// @desc slide transition (mode, targetroom) 
///@arg Mode sets transition mode between next, restart and goto 
///@arg target sets target room when using the goto mode 
function SlideTransition(mode, target=undefined){
	oTransition.mode = mode
	if target != undefined {
		oTransition.target = target	
	}
}