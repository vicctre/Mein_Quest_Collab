
view_w = 512
view_h = 288
win_w = window_get_width()
win_h = window_get_height()

ratio = win_w / view_w
if (win_w mod view_w) != 0 {
    var lower_ratio = floor(ratio)
    var higher_ratio = ceil(ratio)
    ratio = abs(ratio - lower_ratio) 
                < abs(ratio - higher_ratio) 
            ? lower_ratio
            : higher_ratio
}
view_w = win_w / ratio
view_h = win_h / ratio


view_enabled = true
view_visible[0] = true


camera_set_view_size(view_camera[0], view_w, view_h)

alarm[1] = 10
