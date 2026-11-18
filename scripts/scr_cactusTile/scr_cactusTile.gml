function CactusTile(vid) : Tile(vid, false) constructor
{
	connectsToSand = true;
	
	render = function(screen, level, xx, yy)
	{
		var col = Color.get(20, 40, 50, level.sandColor);
		screen.render(xx * 16 + 0, yy * 16 + 0, 8 + 2 * 32, col, 0);
		screen.render(xx * 16 + 8, yy * 16 + 0, 9 + 2 * 32, col, 0);
		screen.render(xx * 16 + 0, yy * 16 + 8, 8 + 3 * 32, col, 0);
		screen.render(xx * 16 + 8, yy * 16 + 8, 9 + 3 * 32, col, 0);
	}
	mayPass = function(level, xx, yy, e)
	{
		return false;
	}
	hurt6 = function(level, xx, yy, source, dmg, attackDir)
	{
		var damage = level.getData(xx, yy) + dmg;
		level.add(new SmashParticle(xx * 16 + 8, yy * 16 + 8));
		level.add(new TextParticle(string(dmg), xx * 16 + 8, yy * 16 + 8, Color.get(-1, 500, 500, 500)));
		if (damage >= 10)
		{
			var count = prandom.nextInt(2) + 1;
			for (var i = 0; i < count; i++)
				level.add(new ItemEntity(new ResourceItem(Resource.cactusFlower), xx * 16 + prandom.nextInt(10) + 3, yy * 16 + prandom.nextInt(10) + 3));
			level.setTile(xx, yy, Tile.sand, 0);
		}
		else
			level.setData(xx, yy, damage);
	}

	bumpedInto = function(level, xx, yy, entity)
	{
		if (entity != undefined)
			entity.tile_hurt4(self, xx, yy, 1);
	}
	tick = function(level, xt, yt)
	{
		var damage = level.getData(xt, yt);
		if (damage > 0)
			level.setData(xt, yt, damage - 1);		
	}
}