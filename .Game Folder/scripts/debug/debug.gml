/// updates variables of debug scripts
/// it's suggested to put this into some head object
/// in which scr_debug_show_var() is called

function scr_debug_scripts_update() {
	global.VAR_BAR_LENGTH = 0
	global.VAR_BAR_X = 30
	global.VAR_BAR_Y = 30
}

function scr_debug_show_grid(grid, x0, y0) {
	if not global.DEBUG
		return false
	var i, j
	for(i=0;i<ds_grid_width(grid); i+=1) {
	    for(j=0; j<ds_grid_height(grid); j+=1) {
	        draw_text(x0 + 50 * i, y0 + 20 * j, string(ds_grid_get(grid, i, j)))
	    }
	}
}

function scr_debug_show_array2d(arr, x0, y0) {
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

function scr_debug_show_list(list, x0, y0) {
	if not global.DEBUG
		return false
	var i
	for(i=0; i<ds_list_size(list); i+=1) {
	    draw_text(x0, y0 + 20*i, string(ds_list_find_value(list, i)))
	}
}

function scr_debug_ini() {
	global.VAR_BAR_LENGTH = 0
	global.VAR_BAR_X = 0
	global.VAR_BAR_Y = 0
	global.VAR_BAR_ROW_DELTA = 20
	global.DEBUG = true
}

function scr_debug_show_var(text, var_) {
	if not global.DEBUG
		return false
	var font = draw_get_font()
	var h_allign = draw_get_halign()
	draw_set_font(fnt_gui)
	draw_set_halign(fa_left)
	global.VAR_BAR_LENGTH += 1;
	draw_text(global.VAR_BAR_X,
		global.VAR_BAR_Y+global.VAR_BAR_LENGTH*global.VAR_BAR_ROW_DELTA,
		text+" "+string(var_)
	)
	draw_set_font(font)
	draw_set_halign(h_allign)
}
