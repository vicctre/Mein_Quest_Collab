/// @desc move to next room 

with (oPlayerRef) 
{
	if (hascontrol) 
	{
		hascontrol = false; 
		SlideTransition(TRANS_MODE.GOTO,other.target); 
	}
}


