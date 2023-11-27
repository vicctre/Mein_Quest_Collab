///following the PixelatedPopes Camera video, just building the code to see how it fairs 

//scales to more resolutions based on the denominator "6" 
//the higher you need to multiply the scale the less noticable distortion will be 
view_width =1920/6; 
view_height =1080/6; 

//scalled the window 3x the size of the view, making it bigger on the monitor 
window_scale= 3; 

//this will center the view on the monitor 
//has to happen 1 step after you set window size, or new size will not be taken into account 
window_set_size(view_width*window_scale, view_height*window_scale); 
alarm[0]=1 

//application surface controls how many pixels we are using in our window 
//the higher the number, the more res we have, making things scroll smoother
surface_resize(application_surface,view_width*window_scale, view_height*window_scale); 
 
