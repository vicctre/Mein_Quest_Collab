///// define via creation args
// damage
// auto_destroy
hit_instances_list = ds_list_create()
new_instances_list = ds_list_create()
frames = 4
auto_destroy = bool(auto_destroy)

function perform() {
	var num = instance_place_list(x, y, pCut, new_instances_list, false)
	for (var i = 0; i < num; ++i) {
		var inst = new_instances_list[| i]
		if ds_list_find_index(hit_instances_list, inst) == -1 {
			inst.set_hit(damage)
			ds_list_add(hit_instances_list, inst)
		}
	}
    frames -= auto_destroy
	if !frames {
		instance_destroy()
		return;
	}
	ds_list_clear(new_instances_list)
}

if DEV {
	visible = true
}

perform()

