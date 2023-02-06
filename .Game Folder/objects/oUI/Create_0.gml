

var hp_spr = sMeinHP
hp = {
	xoffset: 15,
	yoffset: 15,
	spr: hp_spr,
	max_ind: sprite_get_number(hp_spr)
}

function hp_bar_get_index() {
	if !instance_exists(oPlayer) {
		return 0
	}
	return oPlayer.hp
}

function draw_hp_bar() {
	var xx = scr_camx(0) + hp.xoffset
	var yy = scr_camy(0) + hp.yoffset
	draw_sprite(hp.spr, hp_bar_get_index(), xx, yy)
}
