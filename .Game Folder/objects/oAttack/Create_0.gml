
// damage - define via creation args
list_hit_by_attack = ds_list_create()

function perform() {
	ds_list_clear(list_hit_by_attack)
	var num = instance_place_list(x, y, pCut, list_hit_by_attack, false)
	for (var i = 0; i < num; ++i) {
	    list_hit_by_attack[| i].set_hit(damage)
	}
}

perform()
if one_frame {
	ds_list_destroy(list_hit_by_attack)
	instance_destroy()
}
