
with other {
	hp--
	flash = 3
	//hitfrom = other.direction <- commented this out to see if it breaks anything cuz it looks like it does nothing
}
instance_destroy()

//if (place_meeting(x,y,pCut))
//{
//	with (instance_place(x,y,pCut))
//	{
//		hp--; 
//		flash = 3; 
//		hitfrom = other.direction 
	
//	}
//	instance_destroy(); 
//}

//This is all for the gun in the tutorial 
	//x= lengthdir_x(1, spd)
	//y= lengthdir_y(1, spd)

//if (place_meeting(x,y,oWall)) && (image_index !=0) 
//{
	//while (place_meeting(x,y,oWall)) 
	//{
		//x= lengthdir_x(1, direction)
		//y= lengthdir_y(1, direction)
	//}
	//spd = 0; 
	//instance_change(oContact,true) 
//}


