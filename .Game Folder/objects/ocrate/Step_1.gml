
if (hp <= 0) 
{
	instance_create_layer(x,y,layer,oCutCubeBreak);
	instance_destroy(); 
	audio_play_sound(SFX_CutCube,3,false);
}

