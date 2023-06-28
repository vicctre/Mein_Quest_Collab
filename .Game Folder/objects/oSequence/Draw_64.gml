scr_debug_show_var("","")
scr_debug_show_var("","")
scr_debug_show_var("","")
scr_debug_show_var("","")
scr_debug_show_var("","")

scr_debug_show_var(
	"seq",
	-layer_sequence_get_headpos(sequence_inst)
		   + (layer_sequence_get_length(sequence_inst) - 1)
)
scr_debug_scripts_update()
