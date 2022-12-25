function PlayerState_Attack_Slash()
{
	//Shmovment 
	if (!place_meeting(x,y + 1,oWall))
	{	var move = key_right - key_left; 
		hsp = move * walksp;
	}
	else hsp = 0; 
vsp = vsp + grv; 
	
//canjump = 10; 

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


//Attack StartUp 
if (sprite_index != sPlayerAttack) 
{
	sprite_index = sPlayerAttack; 
	image_index = 0; 
	ds_list_clear(hitByAttack); 
	audio_play_sound(SFX_AttackWiff,5,false); 
}

//using attack hitbox 
mask_index = sAttack_Hitbox01; 
var hitByAttackNow = ds_list_create(); 
var hits = instance_place_list(x,y,pCut,hitByAttackNow,false); 
if (hits > 0) 
{
	for (var i = 0; i < hits; i++) 
	{
		//incase it hitbox doesnt connect 
		//"|" finds the AttackNow in the ds_list, like a short cut 
		var hitID = hitByAttackNow[| i];
		//checks to see if a value exists in the ds_list 
		if (ds_list_find_index(hitByAttack,hitID) = -1) 
		{
			ds_list_add(hitByAttack,hitID); 
			with (hitID)
			{
				EnemyHit(1)
			}
		}
	}
}

ds_list_destroy(hitByAttackNow); 
mask_index = sPlayer; 

if (Animation_end()) 
{
	sprite_index = sPlayer; 
	state = PLAYERSTATE.FREE
}
}