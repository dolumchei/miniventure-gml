function ItemEntity(item, xv, yv) : Entity() constructor
{
	self.item = item; 
	
	xx = xv;
	self.x = xv; 
	yy = yv; 
	self.y = yv;
	
	xr = 3; 
	yr = 3; 

	zz = 2; 
	xa = prandom.NextGaussian() * 0.3; 
	ya = prandom.NextGaussian() * 0.2; 
	za = prandom.NextFloat() * 0.7 + 1; 

	lifeTime = 60 * 10 + prandom.NextInt(60); 
	time = 0; 

	tick = function()
	{
		time++; 
		if (time >= lifeTime)
		{ 
			remove(); 
			return; 
		}
		xx += xa; 
		yy += ya; 
		zz += za; 
		if (zz < 0)
		{ 
			zz = 0; 
			za *= -0.5; 
			xa *= 0.6; 
			ya *= 0.6; 
		}
		za -= 0.15; 
		var ox = x; 
		var oy = y; 
		var nx = round(xx); 
		var ny = round(yy); 
		var expectedx = nx - x; 
		var expectedy = ny - y; 
		move(nx - x, ny - y); 
		var gotx = x - ox; 
		var goty = y - oy; 
		xx += gotx - expectedx; 
		yy += goty - expectedy; 
	}
	isBlockableBy = function(mob)
	{
		return false; 
	}
	render = function(screen)
	{
		if (time >= lifeTime - 6 * 20)
		{ 
			if (time / 6 % 2 <= 1)
				return; 
		}
		screen.render(x - 4, y - 4, item.getSprite(), global.Color.get(-1, 0, 0, 0), 0); 
		screen.render(x - 4, y - 4 - round(zz), item.getSprite(), item.getColor(), 0); 
	}
	touchedBy = function(entity)
	{
		if (time > 30) 
			entity.touchItem(self); 
	}
	take = function(player)
	{
		global.Sound.pickup.play(); 
		player.scoreValue++; 
		item.onTake(self); 
		remove(); 
	}
	
	tile_hurt4 = function(tile, xx, yy, damage) { }
}
