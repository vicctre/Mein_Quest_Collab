
//// initialize needed vars for debug drawing
function debug_draw_ini() {
	global.VAR_BAR_LENGTH = 0
	global.VAR_BAR_X = 0
	global.VAR_BAR_Y_BASE = 0
	global.VAR_BAR_Y = 0
	global.VAR_BAR_ROW_DELTA = 20
	global.DEBUG = true
}

//// Use this function once per step somewhere
function debug_draw_update() {
	global.VAR_BAR_LENGTH = 0
	global.VAR_BAR_X = 30
	global.VAR_BAR_Y = global.VAR_BAR_Y_BASE
}

//// Use following functions in DrawGUI
function debug_draw_grid(grid, x0, y0) {
	if not global.DEBUG
		return false
	var i, j
	for(i=0;i<ds_grid_width(grid); i+=1) {
	    for(j=0; j<ds_grid_height(grid); j+=1) {
	        draw_text(x0 + 50 * i, y0 + 20 * j, string(ds_grid_get(grid, i, j)))
	    }
	}
}

function debug_draw_array2d(arr, x0, y0) {
	if not global.DEBUG
		return false
	var i, j
	var w = array_length(arr)
	for(i=0;i<w; i+=1) {
		var h = array_length(arr[i])
	    for(j=0; j<h; j+=1) {
	        draw_text(x0 + 50 * i, y0 + 20 * j, string(arr[i][j]))
	    }
	}
}

function debug_draw_list(list, x0, y0) {
	if not global.DEBUG
		return false
	var i
	for(i=0; i<ds_list_size(list); i+=1) {
	    draw_text(x0, y0 + 20*i, string(ds_list_find_value(list, i)))
	}
}

function debug_draw_var(text, var_) {
	if not global.DEBUG
		return false
	var h_allign = draw_get_halign()
	draw_set_halign(fa_left)
	global.VAR_BAR_LENGTH += 1;
	draw_text(global.VAR_BAR_X,
		global.VAR_BAR_Y+global.VAR_BAR_LENGTH*global.VAR_BAR_ROW_DELTA,
		text+" "+string(var_)
	)
	draw_set_halign(h_allign)
}
