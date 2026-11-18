tile_colors = array_create(256, 0x000000);
tile_colors[Tile.water.id] = 0x000080;
tile_colors[Tile.grass.id] = 0x208020;
tile_colors[Tile.rock.id] = 0xA0A0A0;
tile_colors[Tile.dirt.id] = 0x604040;
tile_colors[Tile.sand.id] = 0xA0A040; 
tile_colors[Tile.tree.id] = 0x003000;
tile_colors[Tile.lava.id] = 0xFF2020;
tile_colors[Tile.cloud.id] = 0xEEEEEE;
tile_colors[Tile.stairsDown.id] = 0xFFFFFF;
tile_colors[Tile.stairsUp.id] = 0xFFFFFF;
tile_colors[Tile.cloudCactus.id] = 0xDD55DD;
tile_colors[Tile.infiniteFall.id] = 0xCCCCCC;

w = 128;
h = 128;
m = 0;
map = [ ];

surface = -1;
buffer = -1;

surface_ensure = function()
{
	if (!surface_exists(surface))
	{
		surface = surface_create(w, h);
	
		surface_set_target(surface);
		draw_clear(c_black);
		surface_reset_target();
	}
}
buffer_ensure = function()
{
	if (!buffer_exists(buffer))
	{
		var surface_width = surface_get_width(surface);
		var surface_height = surface_get_height(surface);

		buffer = buffer_create(surface_width * surface_height * 4, buffer_fixed, 1);
		buffer_get_surface(buffer, surface, 0);
	}
}
data_ensure = function()
{
	surface_ensure();
	buffer_ensure();
}

generate = function(w = 128, h = 128, m)
{	
	if (surface_get_width(surface) != w || surface_get_height(surface) != h)
		event_perform(ev_cleanup, 0);
		
	static d = 0;
	
	self.w = w;
	self.h = h;
	self.m = m;
	
	map = [ ];
	
	var generation_time = current_time;
	
	switch(m)
	{
		default: 
			map = LevelGen.createAndValidateTopMap(w, h)[0];
		break;
		case 1:
			map = LevelGen.createAndValidateUndergroundMap(w, h, (d++ % 3) + 1)[0];
		break;
		case 2:
			map = LevelGen.createAndValidateSkyMap(w, h)[0];
		break;
	}
	
	generation_time = (current_time - generation_time) / 1000;
	print(m, generation_time);
	
	data_ensure();
	
	buffer_seek(buffer, buffer_seek_start, 0);
	for (var i = 0; i < array_length(map); i++)
	{
		var tile = map[i];		
		var color = tile_colors[tile];
			
		buffer_write(buffer, buffer_u8, color_get_blue(color));
		buffer_write(buffer, buffer_u8, color_get_green(color));
		buffer_write(buffer, buffer_u8, color_get_red(color));
		buffer_write(buffer, buffer_u8, 255);
	}
	buffer_seek(buffer, buffer_seek_end, 0);
	
	buffer_set_surface(buffer, surface, 0);
}

generate(w, h, m);