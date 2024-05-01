//get volume 
var _sfxVol = global.SFX_VOL * global.MASTER_VOL; 

//CutCube sound 
if CutCubeSound == true 
{
	//play sound 
	var _snd = audio_play_sound(SFX_CutCube, 3, false);
	audio_sound_gain(_snd, _sfxVol, 0); 
	
	//reset variable 
	CutCubeSound = false; 
}

if EnemyKOSound == true 
{
	//play sound 
	var _snd = audio_play_sound(SFX_EnemyDead, 4, false);
	audio_sound_gain(_snd, _sfxVol, 0); 
	
	//reset variable 
	EnemyKOSound = false; 
}

if HealSFX == true 
{
	//play sound 
	var _snd = audio_play_sound(global.sfx_heal, 5, false);
	audio_sound_gain(_snd, _sfxVol, 0); 
	
	//reset variable 
	HealSFX = false; 
}

if CoinSFX == true 
{
	//play sound 
	var _snd = audio_play_sound(global.sfx_coin, 3, false);
	audio_sound_gain(_snd, _sfxVol, 0); 
	
	//reset variable 
	CoinSFX = false; 
}

if LeafSFX == true 
{
	//play sound 
	var _snd = audio_play_sound(global.sfx_coin, 2, false);
	audio_sound_gain(_snd, _sfxVol, 0); 
	
	//reset variable 
	CoinSFX = false; 
}