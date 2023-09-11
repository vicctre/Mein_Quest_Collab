
event_inherited()

sp_gain = 0.03
sp = 0


var len = path_get_number(pthSpiritByte)
pathx = path_get_point_x(pthSpiritByte, 0)
pathy = path_get_point_y(pthSpiritByte, 0)
pathxend = path_get_point_x(pthSpiritByte, len-1)
pathyend = path_get_point_y(pthSpiritByte, len-1)

var scale = (x - pathxend) / (pathx - pathxend)
path_rescale(pthSpiritByte, scale, 1)
path_start(pthSpiritByte, 2, path_action_stop, false)
