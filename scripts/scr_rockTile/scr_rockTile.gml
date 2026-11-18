function RockTile(vid) : Tile(vid, false) constructor
{	
	t = self;
	mainColor = 444;
	darkColor = 111;

	render = function(screen, level, xx, yy)
	{
		var col = Color.get(mainColor, mainColor, mainColor - 111, mainColor - 111);
		var transitionColor = Color.get(darkColor, mainColor, mainColor + 111, level.dirtColor);

		var u = level.getTile(xx, yy - 1) != t;
		var d = level.getTile(xx, yy + 1) != t;
		var l = level.getTile(xx - 1, yy) != t;
		var r = level.getTile(xx + 1, yy) != t;

		var ul = level.getTile(xx - 1, yy - 1) != t;
		var dl = level.getTile(xx - 1, yy + 1) != t;
		var ur = level.getTile(xx + 1, yy - 1) != t;
		var dr = level.getTile(xx + 1, yy + 1) != t;

		if (!u && !l)
		{
			if (!ul)
				screen.render(xx * 16 + 0, yy * 16 + 0, 0, col, 0); 
			else
				screen.render(xx * 16 + 0, yy * 16 + 0, 7 + 0 * 32, transitionColor, 3);
		}
		else
			screen.render(xx * 16 + 0, yy * 16 + 0, (l ? 6 : 5) + (u ? 2 : 1) * 32, transitionColor, 3);

		if (!u && !r)
		{
			if (!ur)
				screen.render(xx * 16 + 8, yy * 16 + 0, 1, col, 0); 
			else
				screen.render(xx * 16 + 8, yy * 16 + 0, 8 + 0 * 32, transitionColor, 3);
		} 
		else
			screen.render(xx * 16 + 8, yy * 16 + 0, (r ? 4 : 5) + (u ? 2 : 1) * 32, transitionColor, 3);

		if (!d && !l)
		{
			if (!dl)
				screen.render(xx * 16 + 0, yy * 16 + 8, 2, col, 0); 
			else
				screen.render(xx * 16 + 0, yy * 16 + 8, 7 + 1 * 32, transitionColor, 3);
		} 
		else
			screen.render(xx * 16 + 0, yy * 16 + 8, (l ? 6 : 5) + (d ? 0 : 1) * 32, transitionColor, 3);
		if (!d && !r)
		{
			if (!dr)
				screen.render(xx * 16 + 8, yy * 16 + 8, 3, col, 0); 
			else
				screen.render(xx * 16 + 8, yy * 16 + 8, 8 + 1 * 32, transitionColor, 3);
		} 
		else
			screen.render(xx * 16 + 8, yy * 16 + 8, (r ? 4 : 5) + (d ? 0 : 1) * 32, transitionColor, 3);
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
			if (tool.type == ToolType.pickaxe) 
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
		var damage = level.getData(xx, yy) + dmg;
		level.add(new SmashParticle(xx * 16 + 8, yy * 16 + 8));
		level.add(new TextParticle(string(dmg), xx * 16 + 8, yy * 16 + 8, Color.get(-1, 500, 500, 500)));
		if (damage >= 50)
		{
			var count = prandom.nextInt(4) + 1;
			for (var i = 0; i < count; i++)	
				level.add(new ItemEntity(new ResourceItem(Resource.stone), xx * 16 + prandom.nextInt(10) + 3, yy * 16 + prandom.nextInt(10) + 3));
			count = prandom.nextInt(2);
			for (var i = 0; i < count; i++)
				level.add(new ItemEntity(new ResourceItem(Resource.coal), xx * 16 + prandom.nextInt(10) + 3, yy * 16 + prandom.nextInt(10) + 3));
			level.setTile(xx, yy, Tile.dirt, 0);
		}
		else
			level.setData(xx, yy, damage);
	}
	tick = function(level, xt, yt)
	{
		var damage = level.getData(xt, yt);
		if (damage > 0)
			level.setData(xt, yt, damage - 1);
	}
}
