
mode = "grid" // "read"

// set up grid
grid = [[]]
grid_cols = 3

cursor = {
    id: id,
	col: 0,
	row: 0,
	ind: 0,
	xto: 0, // changed in draw event
	yto: 0, //
	x: 0,
	y: 0,
	speed: 20,
	
	move: function(hinp, vinp) {
		ind += hinp + vinp * id.grid_cols
		// backwards boundary jump
		if ind < 0 {
			ind = id.logs_count - 1	
		}
		// forward boundary jump: adjust if last row is not full
		if (ind - id.logs_count) > 0 {
			ind -= (id.grid_cols - id.last_row_size)
		}
		ind = ind mod id.logs_count
		col = ind mod id.grid_cols
		row = ind div id.grid_cols
		x = approach(x, xto, speed)
		y = approach(y, yto, speed)	
	}
}

var iter = new IterStruct(global.adventure_logs)
logs_count = 0
var count = 0
read_logs = []
while iter.next() {
    array_push(array_last(grid), iter.value())
    logs_count++
	count++
    if count == grid_cols {
        array_push(grid, [])
        count = 0
    }

    var read_log = instance_create_layer(camx_cent() + camw() * count, camy_cent(), layer, oMenuAdvLog)
    read_log.Init(iter.value())
    read_log.ind = count
	read_log.xto = read_log.x
	read_log.visible = false
    array_push(read_logs, read_log)
}

last_row_size = array_length(array_last(grid))



// draw params
draw_scale = 0.5
draw_gap = 0
var w = sprite_get_width(sAdvLog_Blank) * draw_scale
half_logw = w * 0.5
var h = sprite_get_height(sAdvLog_Blank) * draw_scale
draw_xstep = w + draw_gap
draw_ystep = h + draw_gap

draw_xst = camw() * 0.5 - (grid_cols - 1) * w * 0.5
draw_yst = 100








