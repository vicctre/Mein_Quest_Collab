event_inherited()

if instance_exists(attackState.attack_inst) {
    instance_destroy(attackState.attack_inst)
}

for (var i = 0; i < array_length(attackState.zapped_platforms); ++i) {
    var item = attackState.zapped_platforms[i]
    if item.IsZap() {
        item.UnZap()
    }
}
