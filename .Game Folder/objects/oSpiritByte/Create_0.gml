
event_inherited()

var len = path_get_number(pthSpiritByte)
pathx = path_get_point_x(pthSpiritByte, 0)
pathy = path_get_point_y(pthSpiritByte, 0)
pathxend = path_get_point_x(pthSpiritByte, len-1)
pathyend = path_get_point_y(pthSpiritByte, len-1)

sp = 4
path = path_duplicate(pthSpiritByte)
var scale = (x - pathxend) / (pathx - pathxend)
path_rescale(path, scale, 1)
path_start(path, sp, path_action_stop, false)
