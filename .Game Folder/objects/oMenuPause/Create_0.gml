
event_inherited()

menu_y_target_start = -100
menu_y_target_finish = menu_y_target_start + 50
menu_y = menu_y_target_start
//menu_y_target = gui_height * 0.5
menu_y_base = gui_height * 0.5
menu_x = gui_width * 0.5

x_ancor = fa_middle
menu_speed = 0.2

function AnimateEaseIn() {
	menu_y = approach(menu_y, menu_y_target, menu_speed)
}

function AnimationFinished() {
	return abs(menu_y - menu_y_target) < menu_speed
}

function PerformButton(index) {
	index = clamp(index, 0, array_length(menu))
	menu_committed = index
	menu_y_base = menu_y_target_start
	menu_control = false
}

function PerformButtonContinue() {
	PerformButton(0)
}

menu = [
	{
		title: "Continue",
		action: oPause.PauseWithMenuContinue
	},
	{
		title: "Quit",
		action: function() {
			SlideTransition(TRANS_MODE.GOTO, rmMainMenu)
			oPause.SetPaused(false)
		}
	}
]

Init()
