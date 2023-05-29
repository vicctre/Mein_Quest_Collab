
ensure_singleton()

scr_debug_ini()

psys = part_system_create()

p_dust = part_type_create()
var lifetime = 20, size = 1, size_incr = 0
p_dust_sp_incr = -0.1
p_dust_sp = 2
part_type_sprite(p_dust, sDust, false, true, false)
part_type_speed(p_dust, p_dust_sp, p_dust_sp, p_dust_sp_incr, 0)
part_type_life(p_dust, lifetime, lifetime)
part_type_alpha2(p_dust, 1, 0.5)
part_type_size(p_dust, size, size, size_incr, 0)

function emit_dust(xx, yy) {
	part_type_direction(p_dust, 0, 0, 0, 0)
	part_particles_create(psys, xx, yy, p_dust, 1)
	part_type_direction(p_dust, 180, 180, 0, 0)
	part_particles_create(psys, xx, yy, p_dust, 1)
}

function emit_sprint_dust(xx, yy, dir) {
	var _dir = dir ? 0 : 180
	part_type_direction(p_dust, _dir, _dir, 0, 0)
	part_type_speed(p_dust, p_dust_sp*1.6, p_dust_sp*1.6, p_dust_sp_incr, 0)
	part_particles_create(psys, xx, yy, p_dust, 1)
	part_type_speed(p_dust, p_dust_sp * 1.2, p_dust_sp * 1.2, p_dust_sp_incr, 0)
	part_particles_create(psys, xx, yy, p_dust, 1)
	part_type_speed(p_dust, p_dust_sp * 0.8, p_dust_sp * 0.8, p_dust_sp_incr, 0)
	part_particles_create(psys, xx, yy, p_dust, 1)
	part_type_speed(p_dust, p_dust_sp, p_dust_sp, p_dust_sp_incr, 0)
}
