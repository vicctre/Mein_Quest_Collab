
event_inherited()

menu_y_target_start = -100
menu_y_target_finish = menu_y_target_start + 50
menu_y = menu_y_target_start
menu_y_target = gui_height * 0.5
menu_x = gui_width * 0.5

x_ancor = fa_middle

function AnimateEaseIn() {
	menu_y += (menu_y_target - menu_y) * menu_speed
}

function AnimationFinished() {
	return menu_y < menu_y_target_finish
}

function Highlight(txt) {
	return string("> {0} <", txt)
}

function PerformButton(index) {
	menu_committed = index
	menu_y_target = menu_y_target_start
	menu_control = false
}

menu = [
	{
		title: "Quit",
		action: function() {
			SlideTransition(TRANS_MODE.RESTART)	
		}
	},
	{
		title: "Continue",
		action: oPause.PauseWithMenuContinue
	}
]

Init()
