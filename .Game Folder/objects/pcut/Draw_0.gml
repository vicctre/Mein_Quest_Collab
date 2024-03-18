var _x = x; var _y = y;  
x = floor(x); // This fixes the jitter/blue that the player experiences when walking
y = floor(y);

//hitflash
if (flash > 0) {
	flash--; 
	shader_set(SHWhite);
	draw_self(); 
	shader_reset(); 
} else {
	draw_self();
}
x = _x; y = _y;
