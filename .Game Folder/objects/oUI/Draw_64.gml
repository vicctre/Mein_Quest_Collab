
draw_hp_bar()

var scale = 2;
draw_sprite_ext(sCoinCounter, 0, 1230, 70, scale, scale, 0, c_white, 1);

var page_count = 1;
for(var i = 0; i < page_count; i++)
	draw_sprite_ext(sAL_HUD, 0, 1260-65*page_count/2 + 65*i, 140, scale, scale, 0, c_white, 1);
//draw_text_outlined(1320, 50, global.coins, c_white, c_black);