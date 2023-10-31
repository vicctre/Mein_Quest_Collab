/// progressing the transition 

if (mode != TRANS_MODE.OFF) 
{
	if (mode == TRANS_MODE.INTRO)
	{
		percent = max(0,percent - max((percent/10), 0.005)); 
	}
	else
	{
		percent = min(Transition_overlap,percent + max(((Transition_overlap - percent)/10),0.005)); 
	}
	
	if (percent == Transition_overlap) || (percent == 0)
	{
		if transition_delay {
			transition_delay--
			exit
		}
		switch (mode) 
		{
			case TRANS_MODE.INTRO: 
			{
				mode = TRANS_MODE.OFF; 
				break; 
			}
			case TRANS_MODE.NEXT: 
			{
				mode = TRANS_MODE.INTRO; 
				room_goto_next(); 
				break; 
			}
			case TRANS_MODE.GOTO: 
			{
				mode = TRANS_MODE.INTRO; 
				room_goto(target); 
				break; 
			}
			case TRANS_MODE.RESTART:
			{
				mode = TRANS_MODE.OFF; 
				Restart()
				break; 
			}
		}
	}
}


