///@desc ScreenShake(Magnitude,frames) 
///@arg Magnitude sets the length of the shake (radius in pixels) 
///@arg frames sets the length of the shake (60FPS = 1 second) 
function Screen_Shake() {
	with (oCamera)
	{
		if (argument0 > shake_remain) 
		{
			shake_magnitude = argument0; 
			shake_remain = argument0; 
			shake_length = argument1; 
		}
		
	}

}