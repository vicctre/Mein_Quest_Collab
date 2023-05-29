if(hp <= 0) 
{
	if (deadSprite == -1)
		show_message("Error: this enemy's death sprite is not set");
		
	//audio_play_sound(SFX_EnemyDead,6,false)
	oSFX.EnemyKOSound = true;
	var inst = instance_create_layer(x,y,layer, deadEnemy);
	inst.sprite_index = deadSprite;
	inst.image_xscale = -hitDirection; 
	inst.hsp = hitDirection*2;
	inst.vsp = -5;
	inst.image_yscale = size;
	instance_destroy(); 
}


