function HoleTile(vid) : Tile(vid, false) constructor
{
	connectsToSand = true;
	connectsToWater = true;
	connectsToLava = true;
	
	render = function(screen, level, xx, yy)
	{
		var col = Color.get(111, 111, 110, 110);
		var transitionColor1 = Color.get(3, 111, level.dirtColor - 111, level.dirtColor);
		var transitionColor2 = Color.get(3, 111, level.sandColor - 110, level.sandColor);

		var u = !level.getTile(xx, yy - 1).connectsToLiquid();
		var d = !level.getTile(xx, yy + 1).connectsToLiquid();
		var l = !level.getTile(xx - 1, yy).connectsToLiquid();
		var r = !level.getTile(xx + 1, yy).connectsToLiquid();

		var su = u && level.getTile(xx, yy - 1).connectsToSand;
		var sd = d && level.getTile(xx, yy + 1).connectsToSand;
		var sl = l && level.getTile(xx - 1, yy).connectsToSand;
		var sr = r && level.getTile(xx + 1, yy).connectsToSand;

		if (!u && !l)
			screen.render(xx * 16 + 0, yy * 16 + 0, 0, col, 0);
		else
			screen.render(xx * 16 + 0, yy * 16 + 0, (l ? 14 : 15) + (u ? 0 : 1) * 32, (su || sl) ? transitionColor2 : transitionColor1, 0);

		if (!u && !r)
			screen.render(xx * 16 + 8, yy * 16 + 0, 1, col, 0);
		else
			screen.render(xx * 16 + 8, yy * 16 + 0, (r ? 16 : 15) + (u ? 0 : 1) * 32, (su || sr) ? transitionColor2 : transitionColor1, 0);

		if (!d && !l)
			screen.render(xx * 16 + 0, yy * 16 + 8, 2, col, 0);
		else
			screen.render(xx * 16 + 0, yy * 16 + 8, (l ? 14 : 15) + (d ? 2 : 1) * 32, (sd || sl) ? transitionColor2 : transitionColor1, 0);
		
		if (!d && !r)
			screen.render(xx * 16 + 8, yy * 16 + 8, 3, col, 0);
		else	
			screen.render(xx * 16 + 8, yy * 16 + 8, (r ? 16 : 15) + (d ? 2 : 1) * 32, (sd || sr) ? transitionColor2 : transitionColor1, 0);
	}
	mayPass = function(level, xx, yy, e)
	{
		return e.canSwim();
	}
}
