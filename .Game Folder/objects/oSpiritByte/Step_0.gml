
var dir = inst_dir(oSpiritBytePosition)
var dist  = inst_dist(oSpiritBytePosition)

sp = dist * sp_gain
var hspd = lengthdir_x(sp, dir)
var vspd = lengthdir_y(sp, dir)
x += hspd
y += vspd
