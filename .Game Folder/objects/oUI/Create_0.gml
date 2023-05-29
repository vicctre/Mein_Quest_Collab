
var hp_spr = sMeinHP
var hp_scale = 2
hp = {
	scale: hp_scale,
	xoffset: 15 + sprite_get_xoffset(hp_spr) * hp_scale,
	yoffset: 15 + sprite_get_yoffset(hp_spr) * hp_scale,
	spr: hp_spr,
	max_ind: sprite_get_number(hp_spr)
}
hp_shake = new Shaker()

function hp_bar_get_index() {
	return global.player_hp
}

function draw_hp_bar() {
	draw_sprite_ext(hp.spr, hp_bar_get_index(), hp.xoffset, hp.yoffset,
					hp.scale, hp.scale, hp_shake.angle, c_white, 1)
}

function shake_hp() {
	hp_shake.shake()
}
