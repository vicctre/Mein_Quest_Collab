///screen transition setup 

ensure_singleton()

w = display_get_gui_width()
h = display_get_gui_height()
h_half = h *0.5
transition_overlap = 1.2
transition_delay = 0
is_forward = false

enum TRANS_MODE {
	NEXT, 
	GOTO,
	RESTART,
}

enum TRANS_TYPE {
    SLIDE,
    FADE
}
is_on = true
mode = -1
trans_type = TRANS_TYPE.SLIDE
percent = 1
target = room

function IsOff() {
	return !is_on
}
