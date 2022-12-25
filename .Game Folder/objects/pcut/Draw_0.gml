//hitflash
draw_self(); 


if (flash > 0) 
{
	flash --; 
	shader_set (SHWhite);
	draw_self(); 
	shader_reset(); 

} 

