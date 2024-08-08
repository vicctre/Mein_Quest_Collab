/// Drawing the black transition bars 

if is_on {
	draw_set_color(c_black)
    switch trans_type {
        case TRANS_TYPE.SLIDE:
            draw_rectangle(0,0,w,percent*h_half,false) 
            draw_rectangle(0,h,w,h-(percent*h_half),false) 
        break
        case TRANS_TYPE.FADE:
            draw_set_alpha(percent)
            draw_rectangle(0, 0, w, h, false)
            draw_set_alpha(1)
        break
    }
}

debug_draw_var("percent", percent)
