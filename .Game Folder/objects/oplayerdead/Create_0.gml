
hsp = 0; 
vsp = 0; 
grv = 0.25; 
done = 0; 

image_speed = 0; 
image_index = 0; 

audio_play_sound(SFX_Death,6,false); 
game_set_speed(30, gamespeed_fps); 
with (oCamera) follow = other.id; 