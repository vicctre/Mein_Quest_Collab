
scale = 2
text_color = c_white
outline_color = c_black
lose_coins_color = #f93c59
// become transparent if close to the player
coin_counter_alpha = 1
coin_counter_x = 1230
coin_counter_y = 70

//NOTE FROM MUFFIN: testing out making ui move offscreen during sequences
//feel free to move these two variables to wherever you usually leave these variables
global.UI_y_offset = 0;
global.UI_Offscreen = false;
//

area_name_text_timer = 0;
area_name_text_offset = 0;
area_name_text_timer_max = 5*room_speed;
area_name_text_background_opacity = 0.7;
var gui_h = display_get_gui_height()

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

// Draw adv logs
// Take needed data from stage manager
stage_logs = oStageManager.GetStageData(room).adv_logs
stage_log_names = oStageManager.GetStageAdvLogNames(room)
stage_logs_num = array_length(stage_log_names)

var spr = sCheckpointIndicator
checkpoint_indicator = {
	image_speed: 0.33,
	image_index: -1,
	image_number: sprite_get_number(spr),
	sprite_index: spr,
	pause_frame: 45,
	pause_time: 30,
	pause_timer: 0,
	x: 30,
	y: gui_h - 50,
	scale: 4,
	exclude_levels: [W1_1_part1, W1_2_part1, W1_3_part1],

	start_animation: function() {
		image_index = 0
	},
	draw: function() {
		if image_index == -1 {
			return;	
		}
		// trigger pause
		if !pause_timer and abs(image_index - pause_frame) <= image_speed {
			pause_timer = pause_time
			show_debug_message("Animation paused")
		}
		// finish animation
		if image_index >= (image_number - 1) {
			image_index = -1
			return;
		}
		pause_timer--
		image_index += image_speed * (pause_timer <= 0)
		draw_sprite_ext(sprite_index, image_index, x, y,
						scale, scale, 0, c_white, 1)
	},
	need_to_show: function() {
		return !array_contains(exclude_levels, room)
	}
}

function hp_bar_get_index() {
	return global.player_hp
}

function draw_hp_bar() {
	draw_sprite_ext(hp.spr, hp_bar_get_index(), hp.xoffset, hp.yoffset + global.UI_y_offset,
					hp.scale, hp.scale, hp_shake.angle, c_white, 1)
}

function shake_hp() {
	hp_shake.shake()
}

function show_checkpoint_indicator() {
	checkpoint_indicator.start_animation()
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

function ease_out() {
	global.UI_Offscreen = true
}

function ease_in() {
	global.UI_Offscreen = false
}

oEventSystem.Subscribe(Events.cutscene_start, id, ease_out)
oEventSystem.Subscribe(Events.cutscene_end, id, ease_in)
