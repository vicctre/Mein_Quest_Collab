
if oInput.key_escape {
    RoomTransition(TRANS_MODE.GOTO, rmMainMenu,
                   false, 0, TRANS_TYPE.FADE)
}

var hinp = oInput.key_right_pressed - oInput.key_left_pressed
var vinp = oInput.key_down_pressed - oInput.key_up_pressed

if mode == "grid" {
	cursor.ind += hinp + vinp * grid_cols
	if cursor.ind < 0 {
		cursor.ind = logs_count - 1	
	}
	if (cursor.ind - logs_count) > 0 {
		cursor.ind -= (grid_cols - last_row_size)
	}
	cursor.ind = cursor.ind mod logs_count
	cursor.col = cursor.ind mod grid_cols
	cursor.row = cursor.ind div grid_cols
	cursor.x = approach(cursor.x, cursor.xto, cursor.speed)
	cursor.y = approach(cursor.y, cursor.yto, cursor.speed)
}
