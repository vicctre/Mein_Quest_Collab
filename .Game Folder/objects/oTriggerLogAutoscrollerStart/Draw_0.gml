

var yy = y - (
	sprite_get_height(sLog_Cutscene)
	- sprite_get_yoffset(sLog_Cutscene)
	- 12									// image not cropped
)
draw_sprite(sLog_Cutscene, 0, x + draw_tree_rel_x, yy)
