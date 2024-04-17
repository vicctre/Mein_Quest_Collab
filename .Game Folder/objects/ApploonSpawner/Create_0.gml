spawn_delay = 210//180;
counter = 0;
paused = false;

leaf_fall_time = 120;
leaf_count = 6;
leaf_delay = 2;

function pause() {
	paused = true;
}

function unpause() {
	paused = false;
}

leaf_counter = 0;
function spawn_leaf() {
	leaf_counter = (leaf_counter + 2) % 5
	var h_offset = 15 * (1 - leaf_counter / 2)
	instance_create_layer(x + h_offset, y, "Enemies", oFallingLeaf)
	
}