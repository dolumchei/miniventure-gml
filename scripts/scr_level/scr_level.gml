function Level(w, h, level, parentLevel) constructor
{
	static prandom = new Random();
	
	entities = [ ];
	static spriteSorter = function(e0, e1)
	{
		if (e1.y < e0.y)
			return 1;
		if (e1.y > e0.y)
			return -1;
		
		return 0;
	}
	
	grassColor = 141;
	dirtColor = 322;
	sandColor = 550;
	monsterDensity = 8;
	
	if (level < 0)
		dirtColor = 222;
	
	self.depth = level;
	self.w = w;
	self.h = h;
	self.parentLevel = parentLevel;
	
	maps = undefined;
	
	if (level == 0)
		maps = global.singleton_LevelGen.createAndValidateTopMap(w, h);
	else if (level < 0)
	{
		maps = global.singleton_LevelGen.createAndValidateUndergroundMap(w, h, -level);
		monsterDensity = 4;	
	}
	else
	{
		maps = global.singleton_LevelGen.createAndValidateSkyMap(w, h);
		monsterDensity = 4;
	}
	
	tiles = maps[0];
	data = maps[1];
	
	if (!is_undefined(parentLevel))
	{
		for (var yy = 0; yy < h; yy++)
		{
			for (var xx = 0; xx < w; xx++)
			{
				if (parentLevel.getTile(xx, yy) == global.Tile.stairsDown)
				{
					setTile(xx, yy, global.Tile.stairsUp, 0);
					
					var tile = global.Tile.dirt;
					if (level == 0)
						tile = global.Tile.hardRock;
						
					setTile(xx - 1, yy, tile, 0);
					setTile(xx + 1, yy, tile, 0);
					setTile(xx, yy - 1, tile, 0);
					setTile(xx, yy + 1, tile, 0);
					setTile(xx - 1, yy - 1, tile, 0);
					setTile(xx - 1, yy + 1, tile, 0);
					setTile(xx + 1, yy - 1, tile, 0);
					setTile(xx + 1, yy + 1, tile, 0);
				}
			}
		}
	}
	
	entitiesInTiles = array_create(w * h);
	for (var i = 0; i < w * h; i++)
		entitiesInTiles[i] = [ ];
		
	if (level == 1)
	{
		var aw = new AirWizard();
		aw.x = w * 8;
		aw.y = h * 8;
		add(aw);
	}
	
	static renderBackground = function(screen, xScroll, yScroll)
	{
		var xo = xScroll >> 4;
		var yo = yScroll >> 4;
		var wv = (screen.w + 15) >> 4;
		var hv = (screen.h + 15) >> 4;
		screen.setOffset(xScroll, yScroll);
		for (var yy = yo; yy <= hv + yo; yy++)
		{
			for (var xx = xo; xx <= wv + xo; xx++)
			{
				var tile = getTile(xx, yy);
				if (xx - 8 > GAME_WIDTH || xx + 8 < 0)
					continue;
				if (yy - 8 > GAME_HEIGHT || yy + 8 < 0)
					continue;
				
				tile.render(screen, self, xx, yy);
			}
		}
		screen.setOffset(0, 0);
	}
	
	rowSprites = [ ];
	
	player = undefined;
	
	static renderSprites = function(screen, xScroll, yScroll)
	{
		var xo = xScroll >> 4;
		var yo = yScroll >> 4;
		var w = (screen.w + 15) >> 4;
		var h = (screen.h + 15) >> 4;

		screen.setOffset(xScroll, yScroll);
		for (var yy = yo; yy <= h + yo; yy++)
		{
			for (var xx = xo; xx <= w + xo; xx++)
			{
				if (xx < 0 || yy < 0 || xx >= self.w || yy >= self.h)
					continue;
				if (xx - 8 > GAME_WIDTH || xx + 8 < 0)
					continue;
				if (yy - 8 > GAME_HEIGHT || yy + 8 < 0)
					continue;
					
				array_push_array(rowSprites, entitiesInTiles[xx + yy * self.w]);
			}
			if (array_length(rowSprites) > 0)
				sortAndRender(screen, rowSprites);
			rowSprites = [ ];
		}
		screen.setOffset(0, 0);	
	}
	
	static renderLight = function(screen, xScroll, yScroll)
	{
		var xo = xScroll >> 4; 
		var yo = yScroll >> 4; 
		var w = (screen.w + 15) >> 4; 
		var h = (screen.h + 15) >> 4; 

		screen.setOffset(xScroll, yScroll); 
		var r = 4; 
		for (var yp = yo - r; yp <= h + yo + r; yp++)
		{ 
			for (var xp = xo - r; xp <= w + xo + r; xp++)
			{
				if (xp < 0 || yp < 0 || xp >= self.w || yp >= self.h)
					continue; 
				if (xp - 8 > GAME_WIDTH || xp + 8 < 0)
					continue;
				if (yp - 8 > GAME_HEIGHT || yp + 8 < 0)
					continue;
					
				var entities = entitiesInTiles[xp + yp * self.w]; 
				for (var i = 0; i < array_length(entities); i++)
				{
					var e = entities[i]; 
					var lr = e.getLightRadius(); 
					if (lr > 0)
						screen.renderLight(e.x - 1, e.y - 4, lr * 8); 
				}
				var lr = getTile(xp, yp).getLightRadius(self, xp, yp); 
				if (lr > 0)
					screen.renderLight(xp * 16 + 8, yp * 16 + 8, lr * 8); 
			}
		}
		screen.setOffset(0, 0); 
	}

	
	static sortAndRender = function(screen, list)
	{
		array_sort(list, spriteSorter);	
		for (var i = 0; i < array_length(list); i++)
			list[i].render(screen);
	}
	
	static getTile = function(xx, yy)
	{
		if (xx < 0 || yy < 0 || xx >= w || yy >= h)
			return global.Tile.rock;
			
		return global.Tile.tiles[tiles[xx + yy * w]];
	}
	
	static setTile = function(xx, yy, t, dataVal)
	{
		if (xx < 0 || yy < 0 || xx >= w || yy >= h)
			return;
			
		tiles[xx + yy * w] = t.id;
		data[xx + yy * w] = dataVal;
	}
	
	static getData = function(xx, yy)
	{
		if (xx < 0 || yy < 0 || xx >= w || yy >= h)
			return 0;
			
		return data[xx + yy * w] & 0xff;
	}
	
	static setData = function(xx, yy, val)
	{
		if (xx < 0 || yy < 0 || xx >= w || yy >= h)
			return;
			
		data[xx + yy * w] = val;
	}
	
	static add = function(entity)
	{
		if (is_instanceof(entity, Player))
			player = entity;
			
		entity.removed = false;
		array_push(entities, entity);
		entity.init(self);
		
		insertEntity(entity.x >> 4, entity.y >> 4, entity);
	}
	
	static remove = function(e)
	{
		array_delete_item(entities, e);
		var xto = e.x >> 4;
		var yto = e.y >> 4;
		removeEntity(xto, yto, e);
	}
	
	static insertEntity = function(xx, yy, e)
	{
		if (xx < 0 || yy < 0 || xx >= w || yy >= h)
			return;
			
		array_push(entitiesInTiles[xx + yy * w], e);
	}
	
	static removeEntity = function(xx, yy, e)
	{
		if (xx < 0 || yy < 0 || xx >= w || yy >= h)
			return;
			
		var array = entitiesInTiles[xx + yy * w];
		array_delete(array, array_indexof(array, e), 1);
	}
	
	static trySpawn = function(count)
	{
		for (var i = 0; i < count; i++)
		{
			var mob = undefined;
			
			var minLevel = 1;
			var maxLevel = 1;
			
			if (depth < 0)
				maxLevel = (-depth) + 1;
			if (depth > 0)
			{
				minLevel = 4;
				maxLevel = 4;
			}
			
			var lvl = prandom.NextInt(maxLevel - minLevel + 1) + minLevel;
			if (prandom.NextInt(2) == 0) 
				mob = new Slime(lvl);
			else 
				mob = new Zombie(lvl);
			
			if (!is_undefined(mob))
			{
				if (mob.findStartPos(self))
					add(mob);
			}
		}
	}
	
	t = 0;
	static tick = function()
	{		
		trySpawn(1);
		
		for (var i = 0; i < w * h / 50; i++)
		{
			var xt = prandom.NextInt(w);
			var yt = prandom.NextInt(h);
			getTile(xt, yt).tick(self, xt, yt);
		}
		for (var i = 0; i < array_length(entities); i++)
		{
			var e = entities[i];
			var xto = e.x >> 4;
			var yto = e.y >> 4;
			
			e.tick();
			
			if (e.removed)
			{
				array_delete(entities, i--, 1);
				removeEntity(xto, yto, e);
			}
			else
			{
				var xt = e.x >> 4;
				var yt = e.y >> 4;
				
				if (xto != xt || yto != yt)
				{
					removeEntity(xto, yto, e);
					insertEntity(xt, yt, e);
				}
			}
		}		
	}
	
	static getEntities = function(x0, y0, x1, y1)
	{
		var result = [ ]
		var xt0 = (x0 >> 4) - 1; 
		var yt0 = (y0 >> 4) - 1; 
		var xt1 = (x1 >> 4) + 1; 
		var yt1 = (y1 >> 4) + 1; 
		for (var py = yt0; py <= yt1; py++)
		{ 
			for (var px = xt0; px <= xt1; px++)
			{ 
				if (px < 0 || py < 0 || px >= w || py >= h)
					continue; 
				var entities = entitiesInTiles[px + py * self.w]; 
				for (var i = 0; i < array_length(entities); i++)
				{ 
					var e = entities[i]; 
					if (e.intersects(x0, y0, x1, y1))
						array_push(result, e); 
				}
			}
		}
		return result; 
	}
}