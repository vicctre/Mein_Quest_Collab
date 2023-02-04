// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Restart(){
	game_restart()
	game_set_speed(60,gamespeed_fps)
	SlideTransition(TRANS_MODE.GOTO, room)
}