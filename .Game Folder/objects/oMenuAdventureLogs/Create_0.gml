
mode = "grid" // "read"

// set up grid
grid = [[]]
grid_cols = 3

cursor = {
	col: 0,
	row: 0,
	ind: 0,
	xto: 0,
	yto: 0,
	x: 0,
	y: 0,
	speed: 20
}

var iter = new IterStruct(global.adventure_logs)
logs_count = 0
var count = 0
while iter.next() {
    array_push(array_last(grid), iter.value())
    logs_count++
	count++
    if count == grid_cols {
        array_push(grid, [])
        count = 0
    }
}

last_row_size = array_length(array_last(grid))

// draw params
draw_scale = 0.5
draw_gap = 0
var w = sprite_get_width(sAdvLog_Blank) * draw_scale, h = sprite_get_height(sAdvLog_Blank) * draw_scale
draw_xstep = w + draw_gap
draw_ystep = h + draw_gap

draw_xst = camw() * 0.5 - (grid_cols - 1) * w * 0.5
draw_yst = 100
