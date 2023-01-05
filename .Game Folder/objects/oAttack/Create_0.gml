
// damage - define via creation args
var list_hit_by_attack = ds_list_create()
var num = instance_place_list(x, y, pCut, list_hit_by_attack, false)
for (var i = 0; i < num; ++i) {
    list_hit_by_attack[| i].set_hit(damage)
}
ds_list_destroy(list_hit_by_attack)
