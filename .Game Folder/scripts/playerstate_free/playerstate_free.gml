function PlayerState_Free()
{
//Shmovment 
var move = key_right - key_left; 
hsp = move * walksp;
vsp = vsp + grv; 

//Jumping
canjump -= 1; 
if (canjump > 0) and (key_jump) 
{
	vsp = -7; 
	canjump = 0; 
	audio_play_sound(SFX_Jump,6,false);
}


//Horizontal Collision 
if (place_meeting(x+hsp,y,oWall))
{
	while (!place_meeting(x+sign(hsp),y,oWall))
	{
		x = x + sign(hsp); 
	}
	hsp = 0; 
}
x = x + hsp; 

//Vertical Collision 
if (place_meeting(x,y+vsp,oWall))
{
	while (!place_meeting(x,y+sign(vsp),oWall))
	{
		y = y + sign(vsp); 
	}
	vsp = 0; 
}
y = y + vsp; 

//Animation(s) 


//if (place_meeting(x,y+1,oWall)) and (key_down) 
//{
	//hsp = 0; 	
	//sprite_index = sCrouch; 
	//mask_index = sCrouch; 
//}


if (!place_meeting(x,y+1,oWall)) 
{
	
if (sprite_index != sPlayerJump)
	{
		sprite_index = sPlayerFalling; 
		
	}
	
	if (sign(vsp) < 0) sprite_index = sPlayerJump else sprite_index = sPlayerFalling; 
	
}
else 
{
	canjump = 8; 
	if (sprite_index == sPlayerFalling) 
	{
		audio_sound_pitch(SFX_Land, choose (0.8,1.0,1.2));
		audio_play_sound(SFX_Land,4,false); 
		repeat(4)
		{
			with (instance_create_layer(x,bbox_bottom,"effects",oLanding))
			{
				 vsp = 0; 
			}
		}
	
	}
	image_speed = 1; 
	if (hsp == 0)
	{
		sprite_index = sPlayer; 
	}
	else
	{
		sprite_index = sPlayerW; 
	}
}


if (hsp != 0) image_xscale = sign(hsp); 

if (key_Attack) state = PLAYERSTATE.ATTACK_SLASH;

}