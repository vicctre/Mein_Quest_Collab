
ensure_singleton()

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

p_attack_contact = part_type_create()
part_type_sprite(p_attack_contact, sContact, true, true, false)
part_type_life(p_attack_contact, 18, 18)
part_type_orientation(p_attack_contact, 0, 360, 0, 0, false)
function emit_attack_contact(xx, yy) {
	part_particles_create(psys, xx, yy, p_attack_contact, 1)
}

function emit_dust_ext(xx, yy, sp, dir=0) {
	part_type_direction(p_dust, dir, dir, 0, 0)
	part_type_speed(p_dust, sp, sp, 0, 0)
	part_particles_create(psys, xx, yy, p_dust, 1)
	part_type_gravity(p_dust, 0.025, 90)
	part_type_size(p_dust, 1, 1, 0, 0)
}


p_log_break = part_type_create()
var size = 1, size_incr = 0
var lifetime = 20
p_dust_sp_incr = -0.1
part_type_sprite(p_log_break, sLog_Ride_Break, true, true, false)
part_type_speed(p_log_break, global.autoscroller_log_sp, global.autoscroller_log_sp, 0, 0)
part_type_life(p_log_break, lifetime, lifetime)

function emit_log_break(x, y) {
	part_particles_create(psys, x, y, p_log_break, 1)
}
