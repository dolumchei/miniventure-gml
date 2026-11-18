function LevelGen(w, h, featureSize) constructor
{
	static prandom = new Random();	
	
	if (w != undefined)
	{
		self.w = w;
		self.h = h;
	
		values = array_create(w * h);
	}
	
	sample = function(xx, yy)
	{
		return values[(xx & (w - 1)) + (yy & (h - 1)) * w];
	}
	setSample = function(xx, yy, value)
	{
		values[(xx & (w - 1)) + (yy & (h - 1)) * w] = value;	
	}
	
	static createAndValidateTopMap = function(w, h)
	{	
		while (true)
		{
			var result = createTopMap(w, h);
			
			var count = array_create(256);
			
			for (var i = 0; i < w * h; i++)
				count[result[0][i] & 0xFF]++;	
			
			if (count[Tile.rock.id & 0xFF] < 100)
				continue;
			if (count[Tile.sand.id & 0xFF] < 100)
				continue;
			if (count[Tile.grass.id & 0xFF] < 100)
				continue;
			if (count[Tile.tree.id & 0xFF] < 100)
				continue;
			if (count[Tile.stairsDown.id & 0xFF] < 2) 
				continue;
			
			return result;
		}
	}
	static createAndValidateUndergroundMap = function(w, h, vdepth)
	{
		while (true)
		{
			var result = createUndergroundMap(w, h, vdepth);
			
			var count = array_create(256);
			
			for (var i = 0; i < w * h; i++)
				count[result[0][i] & 0xFF]++;	
			
			if (count[Tile.rock.id & 0xFF] < 100)
				continue;
			if (count[Tile.dirt.id & 0xFF] < 100)
				continue;
			if (count[(Tile.ironOre.id & 0xFF) + vdepth - 1] < 20)
				continue;
			if (vdepth < 3)
			{
				if (count[Tile.stairsDown.id & 0xFF] < 2)
					continue;
			}
			
			return result;
		}
	}
	static createAndValidateSkyMap = function(w, h)
	{
		while (true)
		{
			var result = createSkyMap(w, h);
			
			var count = array_create(256);
			
			for (var i = 0; i < w * h; i++)
				count[result[0][i] & 0xFF]++;	
			
			if (count[Tile.cloud.id & 0xFF] < 2000)
				continue;
			if (count[Tile.stairsDown.id & 0xFF] < 2)
				continue;
			
			return result;
		}
	}
	
	static createTopMap = function(w, h)
	{
		var mnoise1 = new LevelGen(w, h, 16);
		var mnoise2 = new LevelGen(w, h, 16);
		var mnoise3 = new LevelGen(w, h, 16);

		var noise1 = new LevelGen(w, h, 32);
		var noise2 = new LevelGen(w, h, 32);

		var map = array_create(w * h, 0);
		var data = array_create(w * h, 0);
		for (var yp = 0; yp < h; yp++)
		{
			for (var xp = 0; xp < w; xp++)
			{
				var i = xp + yp * w;
				var val = abs(noise1.values[i] - noise2.values[i]) * 3 - 2;
			
				var mval = abs(mnoise1.values[i] - mnoise2.values[i]);
			
				mval = abs(mval - mnoise3.values[i]) * 3 - 2;

				var xd = xp / (w - 1.0) * 2 - 1;
				var yd = yp / (h - 1.0) * 2 - 1;
				if (xd < 0)
					xd = -xd;
				if (yd < 0) 
					yd = -yd;
				var dist = xd >= yd ? xd : yd;
				dist = dist * dist * dist * dist;
				dist = dist * dist * dist * dist;
				val = val + 1 - dist * 20;
				if (val < -0.5)
					map[i] = Tile.water.id;
				else if (val > 0.5 && mval < -1.5)
					map[i] = Tile.rock.id;
				else
					map[i] = Tile.grass.id;
			}
		}
	
		for (var i = 0; i < w * h div 2800; i++)
		{
			var xs = prandom.nextInt(w);
			var ys = prandom.nextInt(h);
			for (var k = 0; k < 10; k++)
			{
				var xp = xs + prandom.nextInt(21) - 10;
				var yp = ys + prandom.nextInt(21) - 10;
				for (var j = 0; j < 100; j++)
				{
					var xo = xp + prandom.nextInt(5) - prandom.nextInt(5);
					var yo = yp + prandom.nextInt(5) - prandom.nextInt(5);
					for (var yy = yo - 1; yy <= yo + 1; yy++)
					{
						for (var xx = xo - 1; xx <= xo + 1; xx++)
						{
							if (xx >= 0 && yy >= 0 && xx < w && yy < h)
							{
								if (map[xx + yy * w] == Tile.grass.id)
									map[xx + yy * w] = Tile.sand.id;
							}
						}
					}
				}
			}
		}

		for (var i = 0; i < w * h div 400; i++)
		{
			var xp = prandom.nextInt(w);
			var yp = prandom.nextInt(h);
			for (var j = 0; j < 200; j++)
			{
				var xx = xp + prandom.nextInt(15) - prandom.nextInt(15);
				var yy = yp + prandom.nextInt(15) - prandom.nextInt(15);
				if (xx >= 0 && yy >= 0 && xx < w && yy < h)
				{
					if (map[xx + yy * w] == Tile.grass.id)
						map[xx + yy * w] = Tile.tree.id;
				}
			}
		}

		for (var i = 0; i < w * h div 400; i++)
		{
			var xp = prandom.nextInt(w);
			var yp = prandom.nextInt(h);
			var col = prandom.nextInt(4);
			for (var j = 0; j < 30; j++)
			{
				var xx = xp + prandom.nextInt(5) - prandom.nextInt(5);
				var yy = yp + prandom.nextInt(5) - prandom.nextInt(5);
				if (xx >= 0 && yy >= 0 && xx < w && yy < h)
				{
					if (map[xx + yy * w] == Tile.grass.id)
					{
						map[xx + yy * w] = Tile.flower.id;
						data[xx + yy * w] = (col + prandom.nextInt(4) * 16);
					}
				}
			}
		}

		for (var i = 0; i < w * h div 100; i++)
		{
			var xx = prandom.nextInt(w);
			var yy = prandom.nextInt(h);
			if (xx >= 0 && yy >= 0 && xx < w && yy < h)
			{
				if (map[xx + yy * w] == Tile.sand.id)
					map[xx + yy * w] = Tile.cactus.id;
			}
		}

		var count = 0;
		for (var i = 0; i < w * h div 100; i++)
		{
			var xp = prandom.nextInt(w - 2) + 1;
			var yp = prandom.nextInt(h - 2) + 1;

			var stairsLoop = true;
			for (var yy = yp - 1; yy <= yp + 1; yy++)
			{
				for (var xx = xp - 1; xx <= xp + 1; xx++)
				{
					if (map[xx + yy * w] != Tile.rock.id)
					{
						stairsLoop = false;
						break;
					}
				}
				
				if (!stairsLoop)
					break;
			}
			
			if (!stairsLoop)
				continue;
			
			map[xp + yp * w] = Tile.stairsDown.id;
			count++;
			if (count == 4)
				break;
		}

		return [ map, data ];
	}

	static createUndergroundMap = function(w, h, vdepth)
	{
		var mnoise1 = new LevelGen(w, h, 16);
		var mnoise2 = new LevelGen(w, h, 16);
		var mnoise3 = new LevelGen(w, h, 16);

		var nnoise1 = new LevelGen(w, h, 16);
		var nnoise2 = new LevelGen(w, h, 16);
		var nnoise3 = new LevelGen(w, h, 16);

		var wnoise1 = new LevelGen(w, h, 16);
		var wnoise2 = new LevelGen(w, h, 16);
		var wnoise3 = new LevelGen(w, h, 16);

		var noise1 = new LevelGen(w, h, 32);
		var noise2 = new LevelGen(w, h, 32);

		var map = array_create(w * h, 0);
		var data = array_create(w * h, 0);
		for (var yp = 0; yp < h; yp++)
		{
			for (var xp = 0; xp < w; xp++)
			{
				var i = xp + yp * w;
				var val = abs(noise1.values[i] - noise2.values[i]) * 3 - 2;
			
				var mval = abs(mnoise1.values[i] - mnoise2.values[i]);
				mval = abs(mval - mnoise3.values[i]) * 3 - 2;

				var nval = abs(nnoise1.values[i] - nnoise2.values[i]);
				nval = abs(nval - nnoise3.values[i]) * 3 - 2;

				var wval = abs(wnoise1.values[i] - wnoise2.values[i]);
				wval = abs(nval - wnoise3.values[i]) * 3 - 2;

				var xd = xp / (w - 1.0) * 2 - 1;
				var yd = yp / (h - 1.0) * 2 - 1;
				if (xd < 0)
					xd = -xd;
				if (yd < 0) 
					yd = -yd;
				var dist = xd >= yd ? xd : yd;
				dist = dist * dist * dist * dist;
				dist = dist * dist * dist * dist;
				val = val + 1 - dist * 20;

				if (val > -2 && wval < -2.0 + (vdepth) / 2 * 3)
				{
					if (vdepth > 2)
						map[i] = Tile.lava.id;
					else
						map[i] = Tile.water.id;
				} 
				else if (val > -2 && (mval < -1.7 || nval < -1.4))
					map[i] = Tile.dirt.id;
				else
					map[i] = Tile.rock.id;
			}
		}

		var r = 2;
		for (var i = 0; i < w * h div 400; i++)
		{
			var xp = prandom.nextInt(w);
			var yp = prandom.nextInt(h);
			for (var j = 0; j < 30; j++)
			{
				var xx = xp + prandom.nextInt(5) - prandom.nextInt(5);
				var yy = yp + prandom.nextInt(5) - prandom.nextInt(5);
				if (xx >= r && yy >= r && xx < w - r && yy < h - r)
				{
					if (map[xx + yy * w] == Tile.rock.id)
						map[xx + yy * w] = ((Tile.ironOre.id & 0xff) + vdepth - 1);
				}
			}
		}

		if (vdepth < 3) 
		{
			var count = 0;
			for (var i = 0; i < w * h div 100; i++)
			{
				var xp = prandom.nextInt(w - 20) + 10;
				var yp = prandom.nextInt(h - 20) + 10;

				var stairsLoop = true;
				for (var yy = yp - 1; yy <= yp + 1; yy++)
				{
					for (var xx = xp - 1; xx <= xp + 1; xx++) 
					{
						if (map[xx + yy * w] != Tile.rock.id)
						{
							stairsLoop = false;
							break;
						}
					}
					
					if (!stairsLoop)
						break;
				}
				
				if (!stairsLoop)
					continue;

				map[xp + yp * w] = Tile.stairsDown.id;
				count++;
				if (count == 4)
					break;
			}
		}

		return [ map, data ];
	}
	
	static createSkyMap = function(w, h)
	{
		var noise1 = new LevelGen(w, h, 8);
		var noise2 = new LevelGen(w, h, 8);

		var map = array_create(w * h, 0); 
		var data = array_create(w * h, 0); 
		for (var yp = 0; yp < h; yp++)
		{
			for (var xp = 0; xp < w; xp++)
			{
				var i = xp + yp * w;
				var val = abs(noise1.values[i] - noise2.values[i]) * 3 - 2;

				var xd = xp / (w - 1.0) * 2 - 1;
				var yd = yp / (h - 1.0) * 2 - 1;
				if (xd < 0) 
					xd = -xd;
				if (yd < 0)
					yd = -yd;
				var dist = xd >= yd ? xd : yd;
				dist = dist * dist * dist * dist;
				dist = dist * dist * dist * dist;
				val = -val * 1 - 2.2;
				val = val + 1 - dist * 20;

				if (val < -0.25)
					map[i] = Tile.infiniteFall.id;
				else
					map[i] = Tile.cloud.id;
			}
		}

	
		for (var i = 0; i < w * h / 50; i++)
		{
			var xp = prandom.nextInt(w - 2) + 1;
			var yp = prandom.nextInt(h - 2) + 1;

			var cactusLoop = true;
			for (var yy = yp - 1; yy <= yp + 1; yy++)
			{
				for (var xx = xp - 1; xx <= xp + 1; xx++)
				{
					if (map[xx + yy * w] != Tile.cloud.id)
					{
						cactusLoop = false;
						break;
					}
				}

				if (!cactusLoop)
					break;
			}
			
			if (!cactusLoop)
				continue;

			map[xp + yp * w] = Tile.cloudCactus.id;
		}

		var count = 0;
		for (var i = 0; i < w * h; i++)
		{
			var xp = prandom.nextInt(w - 2) + 1;
			var yp = prandom.nextInt(h - 2) + 1;

			var stairsLoop = true;
			for (var yy = yp - 1; yy <= yp + 1; yy++)
			{
				for (var xx = xp - 1; xx <= xp + 1; xx++)
				{
					if (map[xx + yy * w] != Tile.cloud.id)
					{
						stairsLoop = false;
						break;
					}
				}

				if (!stairsLoop)
					break;
			}
			
			if (!stairsLoop)
				continue;

			map[xp + yp * w] = Tile.stairsDown.id;
			count++;
			if (count == 2)
				break;
		}

		return [ map, data ];
	}
	
	if (w != undefined)
	{
		for (var yy = 0; yy < w; yy += featureSize)
		{
			for (var xx = 0; xx < w; xx += featureSize)
				setSample(xx, yy, prandom.nextFloat(1) * 2 - 1);
		}
	
		var stepSize = featureSize;
		var scale = 1 / w;
		var scaleMod = 1;
		while (stepSize > 1)
		{
			var halfStep = floor(stepSize / 2);
			for (var yy = 0; yy < w; yy += stepSize)
			{
				for (var xx = 0; xx < w; xx += stepSize)
				{
					var a = sample(xx, yy);
					var b = sample(xx + stepSize, yy);
					var c = sample(xx, yy + stepSize);
					var d = sample(xx + stepSize, yy + stepSize);
				
					var e = (a + b + c + d) / 4 + (prandom.nextFloat(1) * 2 - 1) * stepSize * scale;
					setSample(xx + halfStep, yy + halfStep, e);
				}
			}
			for (var yy = 0; yy < w; yy += stepSize)
			{
				for (var xx = 0; xx < w; xx += stepSize)
				{
					var a = sample(xx, yy);
					var b = sample(xx + stepSize, yy);
					var c = sample(xx, yy + stepSize);
					var d = sample(xx + halfStep, yy + halfStep);
					var e = sample(xx + halfStep, yy - halfStep);
					var f = sample(xx - halfStep, yy - halfStep);
				
					var H = (a + b + d + e) / 4 + (prandom.nextFloat(1) * 2 - 1) * stepSize * scale * 0.5;
					var g = (a + c + d + f) / 4 + (prandom.nextFloat(1) * 2 - 1) * stepSize * scale * 0.5;
				
					setSample(xx + halfStep, yy, H);
					setSample(xx, yy + halfStep, g);
				}
			}
			stepSize = floor(stepSize / 2);
			scale *= (scaleMod + 0.8);
			scaleMod *= 0.3;
		}
	}
}
new LevelGen();