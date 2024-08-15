
frame = 0 // room frame, used for animation
mode = "grid" // "read"

// set up grid
grid = [[]]
grid_cols = 4

cursor = {
    id: id,
	col: 0,
	row: 0,
	ind: 0,
	xto: 0, // changed in draw event
	yto: 0, //
	x: 0,
	y: 0,
	speed_ratio: 0.2,
	speed_min: 10,
    speedv: new Vec2(0, 0),
    image_speed: sprite_frames_per_step(sAdvlog_Select_UI),

	move: function(hinp, vinp, do_clamp=false) {
		ind += hinp + vinp * id.grid_cols
		ind = do_clamp ? clamp(ind, 0, id.logs_count - 1) : ind
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
        speedv.set(xto - x, yto - y)
        if speedv.len() < speed_min {
            x = xto
            y = yto
            return
        }
        if speedv.mult(speed_ratio).len() < speed_min {
            speedv.normalize(speed_min)
        }
		x += speedv.x
		y += speedv.y 
	}
}

logs_count = array_length(global.adventure_logs_array)
read_logs = []
var count = 0
for (var i = 0; i < array_length(global.adventure_logs_array); ++i) {
    var log = global.adventure_logs_array[i]
    array_push(array_last(grid), log)
	count++
    if count == grid_cols {
        array_push(grid, [])
        count = 0
    }
    var read_log = instance_create_layer(
        camx_cent() + camw() * logs_count,
        camy_cent(), layer, oMenuAdvLog)
    read_log.Init(log)
    read_log.ind = i
	read_log.xto = read_log.x
	read_log.visible = false
    array_push(read_logs, read_log)
}

last_row_size = array_length(array_last(grid))



// draw params
draw_scale = 1
draw_gap = 0
var w = sprite_get_width(sAdvLog_Blank) * draw_scale
half_logw = w * 0.5
var h = sprite_get_height(sAdvLog_Blank) * draw_scale
draw_xstep = w + draw_gap
draw_ystep = h + draw_gap

draw_xst = camw() * 0.5 - (grid_cols - 1) * w * 0.5
draw_yst = 250








