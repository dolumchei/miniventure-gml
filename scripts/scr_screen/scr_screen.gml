function Screen(w, h, sheet) constructor
{
	xOffset = 0;
	yOffset = 0;
	
	self.sheet = sheet;
	self.w = w;
	self.h = h;
	
	surface = -1;
	removed = false;
	
	light = -1;
	
	static light_ensure = function()
	{
	    if (removed)
	        return;

	    if (!surface_exists(light))
	    {
	        light = surface_create(w, h);

	        surface_set_target(light);
	        draw_clear_alpha(#0A0A0A, 1);
	        surface_reset_target();
	    }
	}
	static surface_ensure = function()
	{
		if (removed)
			return;
		
		if (!surface_exists(surface))
			surface = surface_create(w, h);		
	}
	
	static free = function()
	{
		if (removed)
			return;
		removed = true;
		
		if (surface_exists(surface))
		{
			surface_free(surface);
			surface = -1;
		}
		if (surface_exists(light))
		{
			surface_free(light);
			light = -1;
		}
	}
	
	static clear = function(color)
	{
	    if (removed)
	        return;

	    surface_ensure();
	    light_ensure();

		surface_set_target(surface);
		draw_clear(color);
		surface_reset_target();

		surface_set_target(light);
		draw_clear(color);
		surface_reset_target();
	}
	
	static render = function(xp, yp, tile, colors, bits, drawRegardless = false)
	{
		if (removed)
			return;
		surface_ensure();
		
		xp -= xOffset;
		yp -= yOffset;

		var mirrorX = (bits & BIT_MIRROR_X) > 0;
		var mirrorY = (bits & BIT_MIRROR_Y) > 0;
		
		var xTile = tile % 32;
		var yTile = tile div 32;
		
		var xp2 = xp;
		var yp2 = yp;
		
		if (mirrorX)
			xp2 += 8;
		if (mirrorY)
			yp2 += 8;
			
		if (!drawRegardless)
		{
			if (xp2 - 8 > GAME_WIDTH || xp2 + 8 < 0)
				return;
			if (yp2 - 8 > GAME_HEIGHT || yp2 + 8 < 0)
				return;
		}
		
		if (is_array(colors))
			colors = global.Color.getArray(colors[0], colors[1], colors[2], colors[3]);
		
		surface_set_target(surface);
		
		shader_set(shd_palette);
		shader_set_uniform_f(global.u_PaletteColor[0], colors[0][0], colors[0][1], colors[0][2], colors[0][3]);
		shader_set_uniform_f(global.u_PaletteColor[1], colors[1][0], colors[1][1], colors[1][2], colors[1][3]);
		shader_set_uniform_f(global.u_PaletteColor[2], colors[2][0], colors[2][1], colors[2][2], colors[2][3]);
		shader_set_uniform_f(global.u_PaletteColor[3], colors[3][0], colors[3][1], colors[3][2], colors[3][3]);
		
		draw_sprite_part_ext(sheet, 0, xTile * 8, yTile * 8, 8, 8, floor(xp2), yp2, mirrorX ? -1 : 1, mirrorY ? -1 : 1, c_white, 1)

		shader_reset();
		
		surface_reset_target();
	}
	
	static setOffset = function(xOffset, yOffset)
	{
		self.xOffset = xOffset;
		self.yOffset = yOffset;
	}

	static overlay = function(screen2, xa, ya)
	{		
		if (removed || screen2.removed)
		    return;

		surface_ensure();

		if (!surface_exists(screen2.surface))
		    return;

		gpu_set_blendmode(bm_normal);

		surface_set_target(surface);

		shader_set(shd_dither);
		shader_set_uniform_f(global.u_DitherSize, screen2.w, screen2.h);
		shader_set_uniform_f(global.u_DitherOffset, xa, ya);

		draw_surface(screen2.surface, 0, 0);

		shader_reset();
		surface_reset_target();
	}
	
	static renderLight = function(xp, yp, r)
	{
	    if (removed || r <= 0)
	        return;

	    surface_ensure();

	    if (!surface_exists(surface))
	        return;

	    if (!surface_exists(light))
	        light_ensure();

	    xp -= xOffset;
	    yp -= yOffset;

	    surface_set_target(light);

	    shader_set(shd_light);
	    shader_set_uniform_f(global.u_LightCenter, xp, yp);
	    shader_set_uniform_f(global.u_LightRadius, r);

	    draw_surface(surface, 0, 0);

	    shader_reset();
	    surface_reset_target();

	    var oldSurface = surface;
	    surface = light;
	    light = oldSurface;
	}
}