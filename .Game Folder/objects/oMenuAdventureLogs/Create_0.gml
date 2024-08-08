
// set up grid
grid = [[]]
grid_cols = 3

var iter = new IterStruct(global.adventure_logs)
var count = 0
while iter.next() {
    array_push(array_last(grid), iter.value())
    count++
    if count == grid_cols {
        array_push(grid, [])
    }
}

// draw params
draw_scale = 0.5
draw_gap = 10
var w = sprite_get_width(sAdvLog_Blank) * draw_scale, h = sprite_get_height(sAdvLog_Blank) * draw_scale
draw_xstep = w + draw_gap
draw_ystep = h + draw_gap

draw_xst = camw() * 0.5 - (grid_cols * 0.5) * w + (grid_cols - 1) * draw_gap * 0.5 + w * 0.25
draw_yst = 100
