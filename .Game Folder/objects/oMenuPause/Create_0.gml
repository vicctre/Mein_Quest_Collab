
event_inherited()

menu_x = gui_width * 0.5
menu_y_base = gui_height * 0.5
menu_y_target_start = -100
menu_y_target_finish = menu_y_target_start + 50
menu_y = menu_y_target_start
menu_speed = 0.2

menu_cursor_scale = 1
menu_text_scale = 1
menu_itemheight = font_get_size(fMenu) * menu_text_scale

function AnimateEaseIn() {
	menu_y = approach(menu_y, menu_y_target, menu_speed)
}

// Ease in finished
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
			RoomTransition(TRANS_MODE.GOTO, rmMainMenu)
			oPause.SetPaused(false)
			oEventSystem.Notify(Events.stage_exit)
		}
	}
]

UpdateMenuBounds()
