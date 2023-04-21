
if (hp <= 0) 
{
	instance_create_layer(x,y,layer,oChestOpen);
	instance_create_depth(x,y,depth-1,oFood);
	instance_destroy(); 
	//audio_play_sound(SFX_CutCube,3,false);
}

