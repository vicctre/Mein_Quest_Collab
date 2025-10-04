
function draw_hit_blinking(phase, color=global.player_damage_blinking_color) {
	var alpha = 0.5 - lengthdir_x(0.5, phase)
	gpu_set_fog(true, color, 0, 0)
	draw_sprite_ext(
		sprite_index,
		image_index,
		x, y,
		image_xscale, image_yscale,
		rotation, c_white, alpha)
	gpu_set_fog(false, color, 0, 0)
}

function create_enemy_attack(x, y, w, h) {
	return instance_create_layer(x, y, "Enemies", oEnemyAttack,
								 {width: w, height: h})
}
