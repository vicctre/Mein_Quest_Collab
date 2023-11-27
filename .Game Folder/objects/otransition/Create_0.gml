///screen transition setup 

ensure_singleton()

w = display_get_gui_width(); 
h = display_get_gui_height(); 
h_half = h *0.5; 
Transition_overlap = 1.2;
transition_delay = 0

enum TRANS_MODE 
{
	OFF, 
	NEXT, 
	GOTO,
	RESTART,
	INTRO,
}
mode = TRANS_MODE.INTRO
percent = 1; 
target = room; 

function IsOff() {
	return mode == TRANS_MODE.OFF
}
