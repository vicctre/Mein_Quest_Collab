//hitflash
if (flash > 0) {
	flash--; 
	shader_set(SHWhite);
	draw_self(); 
	shader_reset(); 
} else {
	draw_self();
}

draw_text(x, y - 40, layer_get_name(layer))

