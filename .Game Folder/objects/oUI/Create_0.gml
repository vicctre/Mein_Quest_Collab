var hp_spr = sMeinHP
var hp_scale = 2

area_name_text_timer = 0;
area_name_text_offset = 0;
area_name_text_timer_max = 5*room_speed;
area_name_text_background_opacity = 0.7;

hp = {
	scale: hp_scale,
	xoffset: 15 + sprite_get_xoffset(hp_spr) * hp_scale,
	yoffset: 15 + sprite_get_yoffset(hp_spr) * hp_scale,
	spr: hp_spr,
	max_ind: sprite_get_number(hp_spr)
}
hp_shake = new Shaker()

checkpoint = {
	time: 180,
	timer: 0,
	sprite: sCheckpoint
}

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

function get_stage_name(room_) {
	switch(room_) {
		case W1_1_part1:
			return "Longroot Lane 1-1";
		break;
		case W1_2_part1:
			return "Longroot Lane 1-2";
		break;
		case W1_3_part1:
			return "Longroot Lane 1-3";
		break;
	}
}