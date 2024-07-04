
function Point(_x, _y) constructor {
	x_ = _x
	y_ = _y

	static add = function(dx, dy) {
		return new Point(self.x_ + dx, self.y_ + dy)
	}
}

function Vec2(xx, yy, is_polar=false) constructor {
	x = xx
	y = yy

	add_coords = function(xx, yy) {
		self.x += xx
		self.y += yy
		return self
	}

	add_coords_ = function(xx, yy) {
		return new Vec2(self.x + xx, self.y + yy)
	}

	add = function(vec) {
		self.x += vec.X
		self.y += vec.Y
		return self
	}

	add_ = function(vec) {
		return new Vec2(self.x + vec.X, self.y + vec.Y)
	}

	sub = function(vec) {
		self.x -= vec.X
		self.y -= vec.Y
		return self
	}

	sub_ = function(vec) {
		return new Vec2(self.x - vec.X, self.y - vec.Y)
	}

	dir = function() {
		return point_direction(0, 0, x, y)
	}

	len = function() {
		return point_distance(0, 0, x, y)	
	}

	normalize = function(len) {
		if len == undefined
			len = 1
		var l = self.len() 
		if l == 0
			return self
		self.x *= len / l
		self.y *= len / l
		return self
	}
	
	set = function(xx, yy) {
		self.x = xx
		self.y = yy
		return self
	}

	set_polar = function(l, dir) {
		self.x = lengthdir_x(l, dir)
		self.y = lengthdir_y(l, dir)	
		return self
	}

	add_polar = function(l, dir) {
		self.x += lengthdir_x(l, dir)
		self.y += lengthdir_y(l, dir)
		return self
	}
	
	add_polar_ = function(l, dir) {
		return new Vec2(self.x, self.y).add_polar(l, dir)
	}

	rotated = function(angle) {
		return new Vec2(self.len(), self.dir() + angle, true)
	}
	
	rotate = function(angle) {
		self.set_polar(self.len(), self.dir() + angle)
		return self
	}
	
	copy = function() {
		return new Vec2(self.x, self.y)
	}
	
	eq = function(vec) {
		return (self.x == vec.X) and (self.y == vec.Y)
	}
	
	move_to_vec = function(vec, sp_mag) {
		var delta = vec.sub_(self)
		if delta.len() < sp_mag
			return self.set(vec.X, vec.Y)
		var sp = delta.normalize(sp_mag)
		return self.add(sp)
	}
	
	approach = function(to, sp) {
		x = global.approach(x, to.X, sp.X)
		y = global.approach(y, to.Y, sp.Y)
		return self
	}
	
	absolutize = function() {
		x = abs(x)
		y = abs(y)
		return self
	}
	
	mult = function(n) {
		x *= n
		y *= n
		return self
	}
	
	mult_ = function(n) {
		return new Vec2(x*n, y*n)	
	}

	if is_polar == true
		self.set_polar(xx, yy)
}


function Line(_xst, _yst, _xend, _yend) constructor {
	xst = _xst
	yst = _yst
	xend = _xend
	yend = _yend

	static mult = function(m) {
		xend = xst + (xend - xst) * m
		yend = yst + (yend - yst) * m
	}

	static set = function(_xst, _yst, _xend, _yend) {
		xst = _xst
		yst = _yst
		xend = _xend
		yend = _yend
	}

	static setst = function(_xst, _yst) {
		xst = _xst
		yst = _yst
	}

	static setend = function(_xend, _yend) {
		xend = _xend
		yend = _yend
	}

	static draw = function() {
		draw_line(xst, yst, xend, yend)
	}

	static get_point_on = function(m) {
		var xx = xst + (xend - xst) * m
		var yy = yst + (yend - yst) * m
		return new Vec2(xx, yy)
	}
	
	static len = function() {
		return point_distance(xst, yst, xend, yend)
	}
}

function line_intersection(l1, l2, segment) {
	var x0, y0, x1, y1, x2, y2, x3, y3
	x0 = l1.xst
	y0 = l1.yst
	x1 = l1.xend
	y1 = l1.yend
	x2 = l2.xst
	y2 = l2.yst
	x3 = l2.xend
	y3 = l2.yend
    var ua, ub, ud, ux, uy, vx, vy, wx, wy
    ua = 0
    ux = x1 - x0
    uy = y1 - y0
    vx = x3 - x2
    vy = y3 - y2

	// ensure lines are not parallel
	if vy == 0
		if uy == 0
			return infinity
	if ux / uy == vx / vy
		return infinity

    wx = x0 - x2
    wy = y0 - y2
    ud = vy * ux - vx * uy
    if (ud != 0) {
        ua = (vx * wy - vy * wx) / ud
        if (segment) {
            ub = (ux * wy - uy * wx) / ud
            if (ua <= 0 || ua >= 1 || ub <= 0 || ub >= 1)
				ua = 0
        }
    }
    return ua
}

zero2d = new Vec2(0, 0)

function instance_line_collision_point(x0, y0, x1, y1, inst) {

	var line = new Line(x0, y0, x1, y1)
	var btm = inst.bbox_bottom
	var top = inst.bbox_top
	var left = inst.bbox_left
	var right = inst.bbox_right

	// left bound
	var bound = new Line(left, btm, left, top)
	var m1 = line_intersection(line, bound, false)
	// right
	bound.set(right, btm, right, top)
	var m2 = line_intersection(line, bound, false)
	// bottom
	bound.set(left, btm, right, btm)
	var m3 = line_intersection(line, bound, false)
	// top
	bound.set(left, top, right, top)
	var m4 = line_intersection(line, bound, false)
	// ban wrong values
	if (m1 < 0) m1 = infinity
	if (m2 < 0) m2 = infinity
	if (m3 < 0) m3 = infinity
	if (m4 < 0) m4 = infinity
	// the closest point
	var m = min(m1, m2, m3, m4)
	return line.get_point_on(m)

	throw " :instance_line_collision_point: there is no line collision with specified instance"
}

function point_dist2d(p1, p2) {
	return point_distance(p1.X, p1.Y, p2.X, p2.Y)
}

function geom_draw_multiline(points, w=1, c=c_white) {
	for (var i = 0; i < array_length(points) - 1; ++i) {
	    var p = points[i]
		var pp = points[i + 1]
		draw_line_width_color(p.X, p.Y, pp.X, pp.Y, w, c, c)
	}
}
function geom_draw_multiline2(points, w=1, c=c_white) {
	for (var i = 0; i < array_length(points) - 1; ++i) {
	    var p = points[i]
		var pp = points[i + 1]
		draw_line_width_color(p[0], p[1], pp[0], pp[1], w, c, c)
	}
}
function geom_draw_multiline3(points, c=c_white) {
	for (var i = 0; i < array_length(points) - 1; ++i) {
	    var p = points[i]
		var pp = points[i + 1]
		draw_line_width_color(p[0], p[1], pp[0], pp[1], pp[2], c, c)
	}
}

function geometry_draw_line(line, col=c_white) {
	draw_line_color(line.xst, line.yst, line.xend, line.yend, col, col)
}
