
var hp_spr = sMeinHP
hp = {
	xoffset: 15,
	yoffset: 15,
	spr: hp_spr,
	max_ind: sprite_get_number(hp_spr)
}
hp_shake = new Shaker()

function hp_bar_get_index() {
	return global.player_hp
}

function draw_hp_bar() {
	var xx = scr_camx(0) + hp.xoffset
	var yy = scr_camy(0) + hp.yoffset
	draw_sprite_ext(hp.spr, hp_bar_get_index(), xx, yy,
					1, 1, hp_shake.angle, c_white, 1)
}

function shake_hp() {
	hp_shake.shake()
}
