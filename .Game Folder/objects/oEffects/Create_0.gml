
ensure_singleton()

scr_debug_ini()

psys = part_system_create()

p_dust = part_type_create()
var size = 1, size_incr = 0
p_dust_lifetime = 20
p_dust_sp_incr = -0.1
p_dust_sp = 2
part_type_sprite(p_dust, sDust, true, true, false)
part_type_speed(p_dust, p_dust_sp, p_dust_sp, p_dust_sp_incr, 0)
part_type_life(p_dust, p_dust_lifetime, p_dust_lifetime)
part_type_alpha2(p_dust, 1, 0.5)
part_type_size(p_dust, size, size, size_incr, 0)

function emit_dust(xx, yy) {
	part_type_direction(p_dust, 0, 0, 0, 0)
	part_type_life(p_dust, p_dust_lifetime, p_dust_lifetime)
	part_particles_create(psys, xx, yy, p_dust, 1)
	part_type_direction(p_dust, 180, 180, 0, 0)
	part_particles_create(psys, xx, yy, p_dust, 1)
	part_type_gravity(p_dust, 0, 90)
}

function emit_sprint_dust(xx, yy, dir) {
	var life_mult = 2
	var sp_mult = 0.8
	var sp_diff = 0.2
	var _dir = dir ? 0 : 180

	part_type_direction(p_dust, _dir, _dir, 0, 0)
	part_type_life(p_dust, p_dust_lifetime*life_mult, p_dust_lifetime*life_mult)
	part_type_gravity(p_dust, 0.05, 90)
	part_type_speed(p_dust, p_dust_sp*sp_mult, p_dust_sp*sp_mult, p_dust_sp_incr, 0)
	part_particles_create(psys, xx, yy, p_dust, 1)

	sp_mult += sp_diff
	part_type_speed(p_dust, p_dust_sp*sp_mult, p_dust_sp*sp_mult, p_dust_sp_incr, 0)
	part_particles_create(psys, xx, yy, p_dust, 1)

	sp_mult += sp_diff
	part_type_speed(p_dust, p_dust_sp*sp_mult, p_dust_sp*sp_mult, p_dust_sp_incr, 0)
	part_particles_create(psys, xx, yy, p_dust, 1)
	
	part_type_speed(p_dust, p_dust_sp, p_dust_sp, p_dust_sp_incr, 0)
}
