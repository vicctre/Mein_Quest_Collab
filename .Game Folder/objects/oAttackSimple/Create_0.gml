
function perform() {
    var target = instance_place(x, y, target_object)
	if one_frame {
		instance_destroy()
	}
    return target
}

if DEV {
	visible = true
}

