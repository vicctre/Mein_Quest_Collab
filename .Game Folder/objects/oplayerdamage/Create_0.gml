
hsp = 0; 
vsp = 0; 
grv = 0.3; 
done = 0; 

image_speed = 0; 
image_index = 0; 

audio_play_sound(SFX_Damage,5,false); 
//game_set_speed(30, gamespeed_fps); 
with (oCamera) follow = other.id; 