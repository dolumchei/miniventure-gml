draw_clear(c_dkgray);

if (surface_exists(surface))
{
	draw_surface(surface, 0, 0);
	
	var map_type = "top";
	if (m == 1)
		map_type = "underground";
	else if (m == 2)
		map_type = "sky";
		
	var text = $"width: {w}\nheight: {h}\nmap: {map_type}";
	draw_text(w + 4, 4, text);
}

draw_text(4, h + 4, "space to generate\nenter to regenerate");