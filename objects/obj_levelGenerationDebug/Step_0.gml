if (keyboard_check_pressed(vk_space))
{
	var level_width = get_integer("level width", w) ?? w;
	var level_height = get_integer("level height", h) ?? h;
	var level_type = get_integer("level map", m) ?? m;
	
	level_type = clamp(level_type, 0, 2);
	
	generate(level_width, level_height, level_type);
}
if (keyboard_check_pressed(vk_enter))
	generate(w, h, m);

	
if (!surface_exists(surface) && buffer_exists(buffer))
{
	data_ensure();
	buffer_set_surface(buffer, surface, 0);
}