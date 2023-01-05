
function Autotiling(layer, x_, y_, 
					tileset, w, h, 
					tile_grid, tile_subset_grid=undefined,
					xst=0, yst=0) constructor {
	self.x_ = x_
	self.y_ = y_
	self.w = w
	self.h = h
	self.tilemap = layer_tilemap_create(layer, x_, y_, tileset, w, h)
	self.tile_grid = tile_grid
	self.tile_subset_grid = tile_subset_grid
	self.xst = xst
	self.yst = yst
	
	if self.tile_subset_grid == undefined {
		self.tile_subset_grid = array2d(array_length(self.tile_grid), array_length(self.tile_grid[0]), 0)
	}

	function draw_region(i, j, ni, nj) {
		for (var ii = i; ii< i + ni; ++ii) {
		    for (var jj = j; jj < j + nj; ++jj) {
				self._draw_tile(ii, jj, true)
			}
		}
	}

	function _draw_tile(i, j) {
		var tile_index = self.compute_tile_index(i, j)
		var tdata = tile_index | 0 | 0
		tilemap_set(self.tilemap, tdata, i, j)
	}

	function compute_tile_index(i, j) {
		var res = (!is_zero_tile(i, j)
				+ 2 * !is_zero_tile(i+1, j)
				+ 4 * !is_zero_tile(i, j+1)
				+ 8 * !is_zero_tile(i+1, j+1))
				// subtileset offset
				+ self.tile_subset_at(i, j) * 16
		return res
	}

	function tile_at(i, j) {
		return self.tile_grid[i+self.xst][j+self.yst]
	}

	function tile_subset_at(i, j) {
		return self.tile_subset_grid[i+self.xst][j+self.yst]
	}

	function is_zero_tile(i, j) {
		return tile_at(i, j) == 0
	}

	function draw() {
		for (var i = 0; i < self.w; ++i) {
		    for (var j = 0; j < self.h; ++j) {
				self._draw_tile(i, j)
			}
		}
	}

	function set_grid_value(i, j, value) {
		self.tile_grid[i+xst][j+yst] = value	
	}

	function set_grid_subset_value(i, j, value) {
		self.tile_subset_grid[i+xst][j+yst] = value	
	}
}

function autotiling_example() {
	//// just call me somwhere
	// set this parameters as you like
	var layer_name = "Instances"
	var tileset_id = generic_ground_tileset
	var xx = 0
	var yy = 0
	// create our terrain grid
	var size = 40
	var terrain = array_create(size)
	for (var i = 0; i < size; ++i) {
	   terrain[i] = array_create(size, 0)
	   for (var j = 0; j < size; ++j) {
		   terrain[i][j] = choose(0, 1)
	   }
	}
	// let's create our tile map now
	var tilemap_size = size - 1
	var autotiler = new Autotiling(layer_name, xx, yy, tileset_id, tilemap_size, tilemap_size, terrain, 0)
	autotiler.draw()
}
