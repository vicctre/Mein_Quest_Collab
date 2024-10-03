
control_hint_text = "X/Enter/A - select\nEsc/Back - go back"

has_control = true

frame = 0 // room frame, used for animation
mode = "grid" // "read"

// set up grid
grid = [[]]
grid_cols = 4
unlocked_array = []

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

	var is_unlocked = oStageManager.IsAdventureLogUnlocked(undefined, log.name)
	read_log.is_unlocked = is_unlocked
    read_log.Init(log)
    read_log.ind = i
	read_log.xto = read_log.x
	read_log.visible = false
    array_push(read_logs, read_log)
	
	unlocked_array[i] = is_unlocked
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




//// Buttons
left_button = collision_rectangle(
    0, 0, room_width * 0.4, room_height, oMenuAdvLogButton, false, true)
right_button = collision_rectangle(
    room_width, 0, room_width * 0.6, room_height, oMenuAdvLogButton, false, true)
left_button.visible = false
right_button.visible = false


function DrawHintText() {
    draw_set_color(c_grey)
    draw_set_halign(fa_left)
    var fnt = draw_get_font()
    draw_set_font(Font01)
    draw_text_transformed(
                room_width * 0.05,//x position of Hint text 
                room_height * 0.1,//y position of Hint text
                control_hint_text,
                0.55, 0.55, 0)
    draw_set_color(c_white)
    draw_set_font(fnt)
}
