if (keyboard_check_pressed(vk_up))
	map--;
if (keyboard_check_pressed(vk_down))
	map++;
	
if (map > array_length(maps) - 1)
	map = 0;
if (map < 0)
	map = array_length(maps) - 1;
	
if (keyboard_check_pressed(vk_enter))
	generate(w, h, m);
	
if (!surface_exists(surfaces[map]) && buffer_exists(buffers[map]))
{
	data_ensure();
	surface_generate();
}