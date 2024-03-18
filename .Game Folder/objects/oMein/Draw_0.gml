//code to help with camera stuff HOPEFULLY (didnt entirly lol) 
var _x = x;
var _y = y;  
x = floor(x); // This fixes the jitter/blue that the player experiences when walking
y = floor(y); // This fixes the jitter/blue that the player experiences when walking  draw_self(); 


if state == PLAYERSTATE.ATTACK_AERAL {
	draw_sprite_ext(
		sprite_index, image_index, x, y, 
		image_xscale, 1, image_draw_angle,
		c_white, 1)
} else {
	draw_self()
	if invincibility_timer-- {
		draw_invincibility_blinking()
	}
}
x = _x; y = _y;
//draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true)
