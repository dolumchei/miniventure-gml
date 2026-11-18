draw_clear(c_dkgray);

if (surface_exists(surfaces[map]))
{
	draw_surface(surfaces[map], 0, 0);
	draw_set_font(fnt_default);
	
	var map_type = "top";
	if (map > 1)
	{
		map_type = $"underground {map - 1}";
	}
	else if (map == 0)
		map_type = "sky";
		
	var text = $"width: {w}\nheight: {h}\nmap: {map_type}";
	draw_text_transformed(w + 4, 4, text, 0.5, 0.5, 0);
}