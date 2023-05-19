vspd = -3;
grav = 0.3;
activated = true;
activation_delay = 30;
flashing = false;
flash_timer = 0;
flash_loop_duration = 120;

uniform = shader_get_uniform(WhiteShader, "white_alpha");
shader_set_uniform_f(uniform, 2*abs(0.5-flash_timer/flash_loop_duration));

collected = function() {
	repeat(7) {
		var inst = instance_create_depth(x+random(30)-15,y+random(30)-15,depth,oHealFizzle);
		inst.direction = point_direction(x, y, inst.x, inst.y);
		inst.speed = 0.5;
	}
}