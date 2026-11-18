tile_colors = array_create(256, 0x000000);
tile_colors[Tile.water.id] = 0x000080;
tile_colors[Tile.grass.id] = 0x208020;
tile_colors[Tile.rock.id] = 0xA0A0A0;
tile_colors[Tile.dirt.id] = 0x604040;
tile_colors[Tile.sand.id] = 0xA0A040; 
tile_colors[Tile.tree.id] = 0x003000;
tile_colors[Tile.lava.id] = 0xFF2020;
tile_colors[Tile.cloud.id] = merge_color(0xEEEEEE, 0xA0A0A0, 0.25);
tile_colors[Tile.stairsDown.id] = 0xFFFFFF;
tile_colors[Tile.stairsUp.id] = 0xFFFFFF;
tile_colors[Tile.cloudCactus.id] = 0xDD55DD;
tile_colors[Tile.infiniteFall.id] = merge_color(0xCCCCCC, 0x000000, 0.25);

tile_colors[Tile.ironOre.id] = 0xDD55DD;
tile_colors[Tile.goldOre.id] = 0xDD55DD;
tile_colors[Tile.gemOre.id] = 0xDD55DD;

tile_colors[Tile.cactus.id] = 0xDD55DD;
tile_colors[Tile.flower.id] = merge_color(0x208020, 0xDD55DD, 0.25);

w = 128;
h = 128;
m = 0;
maps = [ ];

surfaces = [ -1, -1, -1, -1, -1 ];
buffers = [ -1, -1, -1, -1, -1 ];

map = 0;

surface_ensure = function()
{
	for (var i = 0; i < array_length(surfaces); i++)
	{
		var surface = surfaces[i];
		if (!surface_exists(surface) || surface == -1)
		{
			surface = surface_create(w, h);
	
			surface_set_target(surface);
			draw_clear(c_black);
			surface_reset_target();
		}
		surfaces[i] = surface;
	}
}
buffer_ensure = function()
{
	for (var i = 0; i < array_length(buffers); i++)
	{
		var surface = surfaces[i];
		var buffer = buffers[i];
		if (!buffer_exists(buffer) || buffer == -1)
		{
			var surface_width = surface_get_width(surface);
			var surface_height = surface_get_height(surface);

			buffer = buffer_create(surface_width * surface_height * 4, buffer_fixed, 1);
			buffer_get_surface(buffer, surface, 0);
		}
		buffers[i] = buffer;
	}
}
data_ensure = function()
{
	surface_ensure();
	buffer_ensure();
}

surface_generate = function()
{
	for (var i = 0; i < array_length(surfaces); i++)
	{
		var buffer = buffers[i];
		var surface = surfaces[i];
		
		buffer_seek(buffer, buffer_seek_start, 0);
		for (var j = 0; j < array_length(maps[i][0]); j++)
		{
			if (i > 0)
			{
				if (maps[i - 1][0][j] == Tile.stairsDown.id)
					maps[i][0][j] = Tile.stairsUp.id;
			}

			var tile = maps[i][0][j];		
			var color = tile_colors[tile];

			buffer_write(buffer, buffer_u8, color_get_blue(color));
			buffer_write(buffer, buffer_u8, color_get_green(color));
			buffer_write(buffer, buffer_u8, color_get_red(color));
			buffer_write(buffer, buffer_u8, 255);
		}
		buffer_seek(buffer, buffer_seek_end, 0);
	
		buffer_set_surface(buffer, surface, 0);
		
		buffers[i] = buffer;
		surfaces[i] = surface;
	}	
}

generate = function(w = 128, h = 128, m)
{	
	if (surface_get_width(surfaces[0]) != w || surface_get_height(surfaces[0]) != h)
		event_perform(ev_cleanup, 0);
		
	static d = 0;
	
	self.w = w;
	self.h = h;
	self.m = m;
	
	maps = [
		LevelGen.createAndValidateSkyMap(w, h),
		LevelGen.createAndValidateTopMap(w, h),
		LevelGen.createAndValidateUndergroundMap(w, h, 1),
		LevelGen.createAndValidateUndergroundMap(w, h, 2),
		LevelGen.createAndValidateUndergroundMap(w, h, 3)
	];
	
	data_ensure();
	surface_generate();
}

generate(w, h, m);