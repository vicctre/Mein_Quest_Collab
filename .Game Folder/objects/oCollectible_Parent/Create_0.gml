vspd = -3;
grav = 0.3;
activated = true;
activation_delay = 30;
flashing = false;
flash_timer = 0;
flash_loop_duration = 120;

uniform = shader_get_uniform(WhiteShader, "white_alpha");
shader_set_uniform_f(uniform, 2*abs(0.5-flash_timer/flash_loop_duration));