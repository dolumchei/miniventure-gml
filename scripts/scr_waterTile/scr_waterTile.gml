global.waterRandom = array_new_2d(1024, 1024, undefined);

function WaterTile(vid) : singleton_Tile(vid, false) constructor
{
	connectsToSand = true;
	connectsToWater = true;
	
	render = function(screen, level, xx, yy)
	{
		if (global.waterRandom[xx][yy] == undefined)
			global.waterRandom[xx][yy] = [ new Random(), [ 0, 0, 0, 0, 0, 0, 0, 0 ] ];
			
		var wRandom = global.waterRandom[xx][yy][0];
		var randValues = global.waterRandom[xx][yy][1];
		wRandom.SetSeed((tickCount + (xx / 2 - yy) * 4311) / 10 * 54687121 + xx * 3271612 + yy * 3412987161);
		
		var col = global.Color.get(005, 005, 115, 115);
		var transitionColor1 = global.Color.get(3, 005, level.dirtColor - 111, level.dirtColor);
		var transitionColor2 = global.Color.get(3, 005, level.sandColor - 110, level.sandColor);

		var u = !level.getTile(xx, yy - 1).connectsToWater;
		var d = !level.getTile(xx, yy + 1).connectsToWater;
		var l = !level.getTile(xx - 1, yy).connectsToWater;
		var r = !level.getTile(xx + 1, yy).connectsToWater;

		var su = u && level.getTile(xx, yy - 1).connectsToSand;
		var sd = d && level.getTile(xx, yy + 1).connectsToSand;
		var sl = l && level.getTile(xx - 1, yy).connectsToSand;
		var sr = r && level.getTile(xx + 1, yy).connectsToSand;
		
		if (tickCount % 15 == 0)
		{
			if (!u && !l)
			{
				randValues[0] = wRandom.NextInt(4);
				randValues[1] = wRandom.NextInt(4);
			}
			if (!u && !r)
			{
				randValues[2] = wRandom.NextInt(4);
				randValues[3] = wRandom.NextInt(4);
			}
			if (!d && !l)
			{
				randValues[4] = wRandom.NextInt(4);
				randValues[5] = wRandom.NextInt(4);
			}
			if (!d && !r)
			{
				randValues[6] = wRandom.NextInt(4);
				randValues[7] = wRandom.NextInt(4);
			}
		}

		if (!u && !l)
			screen.render(xx * 16 + 0, yy * 16 + 0, randValues[0], col, randValues[1]);
		else
			screen.render(xx * 16 + 0, yy * 16 + 0, (l ? 14 : 15) + (u ? 0 : 1) * 32, (su || sl) ? transitionColor2 : transitionColor1, 0);

		if (!u && !r)
			screen.render(xx * 16 + 8, yy * 16 + 0, randValues[2], col, randValues[3]);
		else
			screen.render(xx * 16 + 8, yy * 16 + 0, (r ? 16 : 15) + (u ? 0 : 1) * 32, (su || sr) ? transitionColor2 : transitionColor1, 0);

		if (!d && !l)
			screen.render(xx * 16 + 0, yy * 16 + 8, randValues[4], col, randValues[5]);
		else
			screen.render(xx * 16 + 0, yy * 16 + 8, (l ? 14 : 15) + (d ? 2 : 1) * 32, (sd || sl) ? transitionColor2 : transitionColor1, 0);
		
		if (!d && !r)
			screen.render(xx * 16 + 8, yy * 16 + 8, randValues[6], col, randValues[7]);
		else
			screen.render(xx * 16 + 8, yy * 16 + 8, (r ? 16 : 15) + (d ? 2 : 1) * 32, (sd || sr) ? transitionColor2 : transitionColor1, 0);	
	}	
	
	static mayPass = function(level, xx, yy, e)
	{
		return e.canSwim();
	}
	static tick = function(level, xt, yt)
	{
		var xn = xt;
		var yn = yt;

		if (prandom.NextBoolean())
			xn += prandom.NextInt(2) * 2 - 1;
		else
			yn += prandom.NextInt(2) * 2 - 1;

		if (level.getTile(xn, yn) == global.Tile.hole)
			level.setTile(xn, yn, self, 0);
	}
}