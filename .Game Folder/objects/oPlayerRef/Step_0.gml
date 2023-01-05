//controls 
//key_left = keyboard_check(vk_left); 
//key_right = keyboard_check(vk_right); 
//key_jump = keyboard_check_pressed(vk_space); 
//key_Attack = keyboard_check_pressed(ord("X")) 

//if (key_left) or (key_right) or (key_jump)
	//{
	//controller = 0; 
	//}
	//Get Player Input 

if (hascontrol) 
{

	key_left = keyboard_check(vk_left) or keyboard_check(ord("A")); 
	key_right = keyboard_check(vk_right) or keyboard_check(ord("D"));  
	key_jump = keyboard_check_pressed(vk_space) or keyboard_check(ord("W"));
	key_down = keyboard_check_pressed(vk_down) or keyboard_check(ord("S")); 
	key_Attack = keyboard_check_pressed(ord("X"));;

if (key_left) || (key_right) || (key_jump) || (key_down)
{
	controller = 0; 
}
	
if (abs(gamepad_axis_value(0,gp_axislh) > 0.2))
{
	key_left = abs(min(gamepad_axis_value(0,gp_axislh),0));
	key_right = max(gamepad_axis_value(0, gp_axislh),0); 
	
}

if (gamepad_button_check_pressed(0,gp_face1))
{
	key_jump = 1; 
	controller = 1; 
}
}
else
{
	key_left = 0; 
	key_right = 0; 
	key_jump = 0; 
	key_down = 0; 
	key_Attack = 0; 
}


//if (gamepad_button_check_pressed(0,gp_face3))
//{
	//key_Attack = 1; 
	//controller = 1; 
//}
//this doesnt get the attack to work on the controller still...fix later? 

switch (state) 
{
	case PLAYERSTATE.FREE: PlayerState_Free(); break; 
	case PLAYERSTATE.ATTACK_SLASH: PlayerState_Attack_Slash(); break; 
	case PLAYERSTATE.ATTACK_COMBO: PlayerState_Attack_Combo(); break; 
	
}

