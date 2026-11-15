function Entity() constructor
{
	prandom = new Random(); 
	x = 0;
	y = 0;;
	xr = 6; 
	yr = 6; 
	removed = false;
	level = undefined; 

	static render = function(screen) { }
	static tick = function() { }
	static remove = function()
	{
		removed = true; 
	}
	static init = function(level)
	{
		self.level = level; 
	}
	static intersects = function(x0, y0, x1, y1)
	{
		return !(x + xr < x0 || y + yr < y0 || x - xr > x1 || y - yr > y1); 
	}
	static blocks = function(e)
	{
		return false;
	}
	static hurt3 = function(mob, dmg, attackDir) { }
	static hurt4 = function(tile, xv, yv, dmg) { }

	static move = function(xa, ya) { return entity_move(xa, ya); }
	static move2 = function(xa, ya) { return entity_move2(xa, ya); }

	static entity_move = function(xa, ya)
	{
		if (xa != 0 || ya != 0)
		{ 
			var stopped = true; 
			if (xa != 0 && entity_move2(xa, 0))
				stopped = false; 
			if (ya != 0 && entity_move2(0, ya))
				stopped = false; 
			if (!stopped)
			{ 
				var xt = x >> 4; 
				var yt = y >> 4; 
				level.getTile(xt, yt).steppedOn(level, xt, yt, self); 
			}
			return !stopped; 
		}
		return true; 
	}
	static entity_move2 = function(xa, ya)
	{
		if (xa != 0 && ya != 0)
			throw ("Move2 can only move along one axis at a time!");
		
		var xto0 = ((x) - xr) >> 4; 
		var yto0 = ((y) - yr) >> 4; 
		var xto1 = ((x) + xr) >> 4; 
		var yto1 = ((y) + yr) >> 4; 

		var xt0 = ((x + xa) - xr) >> 4; 
		var yt0 = ((y + ya) - yr) >> 4; 
		var xt1 = ((x + xa) + xr) >> 4; 
		var yt1 = ((y + ya) + yr) >> 4; 
		
		var blocked = false; 
		for (var yt = yt0; yt <= yt1; yt++) 
		{
			for (var xt = xt0; xt <= xt1; xt++)
			{ 
				if (xt >= xto0 && xt <= xto1 && yt >= yto0 && yt <= yto1)
					continue;
				
				level.getTile(xt, yt).bumpedInto(level, xt, yt, self);  
				if (!level.getTile(xt, yt).mayPass(level, xt, yt, self))
				{ 
					blocked = true; 
					return false;  
				}
			}
		}
		if (blocked)
			return false; 

		var wasInside = level.getEntities(x - xr, y - yr, x + xr, y + yr); 
		var isInside = level.getEntities(x + xa - xr, y + ya - yr, x + xa + xr, y + ya + yr); 
		for (var i = 0; i < array_length(isInside); i++)
		{
			var e = isInside[i]; 
			if (e == self)
				continue; 

			e.touchedBy(self); 
		}
		
		array_removeall(isInside, wasInside); 
		for (var i = 0; i < array_length(isInside); i++)
		{ 
			var e = isInside[i]; 
			if (e == self)
				continue; 

			if (e.blocks(self)) 
				return false; 
		}

		x += xa; 
		y += ya; 
		return true; 
	}
	static touchedBy = function(entity) { }
	static isBlockableBy = function(mob)
	{
		return true; 
	}
	static touchItem = function(itemEntity) { }
	static canSwim = function()
	{
		return false;
	}
	static interact3 = function(player, item, attackDir)
	{
		return item.interact(player, self, attackDir); 
	}
	static use2 = function(player, attackDir)
	{
		return false;
	}
	static getLightRadius = function()
	{
		return 0;
	}
}