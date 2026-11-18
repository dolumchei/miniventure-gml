function TreeTile(vid) : Tile(vid, false) constructor
{
	connectsToGrass = true;
	
	render = function(screen, level, xx, yy)
	{
		var col = Color.get(10, 30, 151, level.grassColor);
		var barkCol1 = Color.get(10, 30, 430, level.grassColor);
		var barkCol2 = Color.get(10, 30, 320, level.grassColor);

		var u = level.getTile(xx, yy - 1) == self;
		var l = level.getTile(xx - 1, yy) == self;
		var r = level.getTile(xx + 1, yy) == self;
		var d = level.getTile(xx, yy + 1) == self;
		var ul = level.getTile(xx - 1, yy - 1) == self;
		var ur = level.getTile(xx + 1, yy - 1) == self;
		var dl = level.getTile(xx - 1, yy + 1) == self;
		var dr = level.getTile(xx + 1, yy + 1) == self;
		
		if (u && ul && l)
			screen.render(xx * 16 + 0, yy * 16 + 0, 10 + 1 * 32, col, 0);
		else
			screen.render(xx * 16 + 0, yy * 16 + 0, 9 + 0 * 32, col, 0);
		
		if (u && ur && r)
			screen.render(xx * 16 + 8, yy * 16 + 0, 10 + 2 * 32, barkCol2, 0);
		else
			screen.render(xx * 16 + 8, yy * 16 + 0, 10 + 0 * 32, col, 0);
		
		if (d && dl && l)
			screen.render(xx * 16 + 0, yy * 16 + 8, 10 + 2 * 32, barkCol2, 0);
		else
			screen.render(xx * 16 + 0, yy * 16 + 8, 9 + 1 * 32, barkCol1, 0);
		
		if (d && dr && r)
			screen.render(xx * 16 + 8, yy * 16 + 8, 10 + 1 * 32, col, 0);
		else
			screen.render(xx * 16 + 8, yy * 16 + 8, 10 + 3 * 32, barkCol2, 0);
	}
	tick = function(level, xt, yt)
	{
		var damage = level.getData(xt, yt);
		if (damage > 0)
			level.setData(xt, yt, damage - 1);	
	}
	mayPass = function(level, xx, yy, e)
	{
		return false;
	}
	hurt6 = function(level, xx, yy, source, dmg, attackDir)
	{
		hurt4(level, xx, yy, dmg);
	}
	interact = function(level, xt, yt, player, item, attackDir)
	{
		if (is_instanceof(item, ToolItem))
		{
			var tool = item;
			if (tool.type == ToolType.axe)
			{
				if (player.payStamina(4 - tool.level))
				{
					hurt4(level, xt, yt, prandom.nextInt(10) + (tool.level) * 5 + 10);
					return true;
				}
			}
		}
		return false;
	}
	hurt4 = function(level, xx, yy, dmg)
	{
		var count = prandom.nextInt(10) == 0 ? 1 : 0;
		for (var i = 0; i < count; i++)
			level.add(new ItemEntity(new ResourceItem(Resource.apple), xx * 16 + prandom.nextInt(10) + 3, yy * 16 + prandom.nextInt(10) + 3));

		var damage = level.getData(xx, yy) + dmg;
		level.add(new SmashParticle(xx * 16 + 8, yy * 16 + 8));
		level.add(new TextParticle(string(dmg), xx * 16 + 8, yy * 16 + 8, Color.get(-1, 500, 500, 500)));
		if (damage >= 20)
		{
			var count = prandom.nextInt(2) + 1;
			for (var i = 0; i < count; i++)
				level.add(new ItemEntity(new ResourceItem(Resource.wood), xx * 16 + prandom.nextInt(10) + 3, yy * 16 + prandom.nextInt(10) + 3));
			count = prandom.nextInt(prandom.nextInt(4) + 1);
			for (var i = 0; i < count; i++)
				level.add(new ItemEntity(new ResourceItem(Resource.acorn), xx * 16 + prandom.nextInt(10) + 3, yy * 16 + prandom.nextInt(10) + 3));
			level.setTile(xx, yy, Tile.grass, 0);
		} 
		else
			level.setData(xx, yy, damage);
	}
}
