function LevelGen(w, h, featureSize, __singleton = false) constructor
{
	static prandom = new Random();
	
	if (!__singleton)
	{
		self.w = w;
		self.h = h;
	
		values = array_create(w * h);
	}
	
	static sample = function(xx, yy)
	{
		return values[(xx & (w - 1)) + (yy & (h - 1)) * w];
	}
	static setSample = function(xx, yy, value)
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
				count[result[0][i] & 0xff]++;	
			
			if (count[global.Tile.rock.id & 0xff] < 100)
				continue;
			if (count[global.Tile.sand.id & 0xff] < 100)
				continue;
			if (count[global.Tile.grass.id & 0xff] < 100)
				continue;
			if (count[global.Tile.tree.id & 0xff] < 100)
				continue;
			if (count[global.Tile.stairsDown.id & 0xff] < 2) 
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
				count[result[0][i] & 0xff]++;	
			
			if (count[global.Tile.rock.id & 0xff] < 100)
				continue;
			if (count[global.Tile.dirt.id & 0xff] < 100)
				continue;
			if (count[(global.Tile.ironOre.id & 0xff) + vdepth - 1] < 20)
				continue;
			if (vdepth < 3)
			{
				if (count[global.Tile.stairsDown.id & 0xff] < 2)
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
				count[result[0][i] & 0xff]++;	
			
			if (count[global.Tile.cloud.id & 0xff] < 2000)
				continue;
			if (count[global.Tile.stairsDown.id & 0xff] < 2)
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

		var map = array_create(w * h);
		var data = array_create(w * h);
		for (var yy = 0; yy < h; yy++)
		{
			for (var xx = 0; xx < w; xx++)
			{
				var i = xx + yy * w;
				
				var val = abs(noise1.values[i] - noise2.values[i]) * 3 - 2;
				var mval = abs(mnoise1.values[i] - mnoise2.values[i]);
				
				mval = abs(mval - mnoise3.values[i]) * 3 - 2;
				
				var xd = xx / (w - 1) * 2 - 1;
				var yd = yy / (h - 1) * 2 - 1;
				if (xd < 0)
					xd = -xd;
				if (yd < 0)
					yd = -yd;
				var dist = xd >= yd ? xd : yd;
				dist = dist * dist * dist * dist;
				dist = dist * dist * dist * dist;
				val = val + 1 - dist * 20;
				if (val < -0.5) 
					map[i] = global.Tile.water.id;
				else if (val > 0.5 && mval < -1.5)
					map[i] = global.Tile.rock.id;
				else
					map[i] = global.Tile.grass.id;
			}
		}
		
		for (var i = 0; i < w * h / 2800; i++)
		{
			var xs = prandom.NextInt(w);
			var ys = prandom.NextInt(h);
			for (var k = 0; k < 10; k++)
			{
				var xx = xs + prandom.NextInt(21) - 10;
				var yy = ys + prandom.NextInt(21) - 10;
				for (var j = 0; j < 100; j++)
				{
					var xo = xx + prandom.NextInt(5) - prandom.NextInt(5);
					var yo = yy + prandom.NextInt(5) - prandom.NextInt(5);
					for (var yy = yo - 1; yy <= yo + 1; yy++)
					{
						for (var xx = xo - 1; xx <= xo + 1; xx++)
						{
							if (xx >= 0 && yy >= 0 && xx < w && yy < h)
							{
								if (map[xx + yy * w] == global.Tile.grass.id)
									map[xx + yy * w] = global.Tile.sand.id;
							}
						}
					}
				}
			}
		}

		for (var i = 0; i < w * h / 400; i++)
		{
			var xx = prandom.NextInt(w);
			var yy = prandom.NextInt(h);
			for (var j = 0; j < 200; j++)
			{
				var xx = xx + prandom.NextInt(15) - prandom.NextInt(15);
				var yy = yy + prandom.NextInt(15) - prandom.NextInt(15);
				if (xx >= 0 && yy >= 0 && xx < w && yy < h)
				{
					if (map[xx + yy * w] == global.Tile.grass.id)
						map[xx + yy * w] = global.Tile.tree.id;
				}
			}
		}

		for (var i = 0; i < w * h / 400; i++)
		{
			var xx = prandom.NextInt(w);
			var yy = prandom.NextInt(h);
			var col = prandom.NextInt(4);
			for (var j = 0; j < 30; j++)
			{
				var xx = xx + prandom.NextInt(5) - prandom.NextInt(5);
				var yy = yy + prandom.NextInt(5) - prandom.NextInt(5);
				if (xx >= 0 && yy >= 0 && xx < w && yy < h)
				{
					if (map[xx + yy * w] == global.Tile.grass.id)
					{
						map[xx + yy * w] = global.Tile.flower.id;
						data[xx + yy * w] = (col + prandom.NextInt(4) * 16);
					}
				}
			}
		}

		for (var i = 0; i < w * h / 100; i++)
		{
			var xx = prandom.NextInt(w);
			var yy = prandom.NextInt(h);
			if (xx >= 0 && yy >= 0 && xx < w && yy < h)
			{
				if (map[xx + yy * w] == global.Tile.sand.id)
					map[xx + yy * w] = global.Tile.cactus.id;
			}
		}

		var count = 0;

		for (var i = 0; i < w * h / 100; i++)
		{
		    var xx = prandom.NextInt(w - 3) + 1;
		    var yy = prandom.NextInt(h - 3) + 1;

		    var valid = true; // multi level break workaround

		    for (var y2 = yy - 1; y2 <= yy + 1; y2++)
		    {
		        for (var x2 = xx - 1; x2 <= xx + 1; x2++)
		        {
		            if (map[x2 + y2 * w] != global.Tile.rock.id)
		            {
		                valid = false;
		                break;
		            }
		        }

		        if (!valid)
		            break;
		    }

		    if (!valid)
		        continue;

		    map[xx + yy * w] = global.Tile.stairsDown.id;
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

		var map = array_create(w * h); 
		var data = array_create(w * h); 
		for (var yv = 0; yv < h; yv++)
		{
			for (var xv = 0; xv < w; xv++)
			{
				var i = xv + yv * w;

				var val = abs(noise1.values[i] - noise2.values[i]) * 3 - 2;
				var mval = abs(mnoise1.values[i] - mnoise2.values[i]);
		
				mval = abs(mval - mnoise3.values[i]) * 3 - 2;

				var nval = abs(nnoise1.values[i] - nnoise2.values[i]);
				nval = abs(nval - nnoise3.values[i]) * 3 - 2;

				var wval = abs(wnoise1.values[i] - wnoise2.values[i]);
		
				wval = abs(nval - wnoise3.values[i]) * 3 - 2;

				var xd = xv / (w - 1.0) * 2 - 1;
				var yd = yv / (h - 1.0) * 2 - 1;
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
						map[i] = global.Tile.lava.id;
					else
						map[i] = global.Tile.water.id;
				} 
				else if (val > -2 && (mval < -1.7 || nval < -1.4))
					map[i] = global.Tile.dirt.id;
				else
					map[i] = global.Tile.rock.id;
			}
		}

		var r = 2;
		for (var i = 0; i < w * h / 400; i++)
		{
			var xv = prandom.NextInt(w); 
			var yv = prandom.NextInt(h);
			for (var j = 0; j < 30; j++)
			{
				var xx = xv + prandom.NextInt(5) - prandom.NextInt(5);
				var yy = yv + prandom.NextInt(5) - prandom.NextInt(5);
				if (xx >= r && yy >= r && xx < w - r && yy < h - r)
				{
					if (map[xx + yy * w] == global.Tile.rock.id)
						map[xx + yy * w] = ((global.Tile.ironOre.id & 0xff) + vdepth - 1);
				}
			}
		}

		if (vdepth < 3)
		{
			var count = 0;
			for (var i = 0; i < w * h / 100; i++)
			{
				var xx = prandom.NextInt(w - 3) + 1;
				var yy = prandom.NextInt(h - 3) + 1;

				var valid = true; // multi level break workaround

				for (var y2 = yy - 1; y2 <= yy + 1; y2++)
				{
					for (var x2 = xx - 1; x2 <= xx + 1; x2++)
					{
						if (map[x2 + y2 * w] != global.Tile.rock.id)
						{
							valid = false;
							break;
						}
					}

					if (!valid)
						break;
				}

				if (!valid)
					continue;

				map[xx + yy * w] = global.Tile.stairsDown.id;
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

		var map = array_create(w * h); 
		var data = array_create(w * h); 
		for (var yv = 0; yv < h; yv++)
		{
			for (var xv = 0; xv < w; xv++) 
			{
				var i = xv + yv * w;
				var val = abs(noise1.values[i] - noise2.values[i]) * 3 - 2;

				var xd = xv / (w - 1.0) * 2 - 1;
				var yd = yv / (h - 1.0) * 2 - 1;
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
					map[i] = global.Tile.infiniteFall.id;
				else
					map[i] = global.Tile.cloud.id;
			}
		}


		for (var i = 0; i < w * h / 50; i++)
		{
			var xv = prandom.NextInt(w - 2) + 1;
			var yv = prandom.NextInt(h - 2) + 1;

			var valid = true; // multi level break workaround

			for (var yy = yv - 1; yy <= yv + 1; yy++)
			{
				for (var xx = xv - 1; xx <= xv + 1; xx++)
				{
					if (map[xx + yy * w] != global.Tile.cloud.id)
					{
						valid = false;
						break;
					}
				}
				if (!valid)
					break;
			}

			if (!valid)
				continue;

			map[xv + yv * w] = global.Tile.cloudCactus.id;
		}

		var count = 0;
		for (var i = 0; i < w * h; i++)
		{
			var xv = prandom.NextInt(w - 2) + 1;
			var yv = prandom.NextInt(h - 2) + 1;

			var valid = true; // multi level break workaround

			for (var yy = yv - 1; yy <= yv + 1; yy++)
			{
				for (var xx = xv - 1; xx <= xv + 1; xx++)
				{
					if (map[xx + yy * w] != global.Tile.cloud.id)
					{
						valid = false;
						break;
					}
				}
				if (!valid)
					break;
			}

			if (!valid)
				continue;

			map[xv + yv * w] = global.Tile.stairsDown.id;
			count++;
			if (count == 2)
				break;
		}
		return [ map, data ];
	}
	
	if (!__singleton)
	{
		for (var yy = 0; yy < w; yy += featureSize)
		{
			for (var xx = 0; xx < w; xx += featureSize)
				setSample(xx, yy, prandom.NextFloat(1) * 2 - 1);
		}
	
		var stepSize = featureSize;
		var scale = 1 / w;
		var scaleMod = 1;
		while (stepSize > 1)
		{
			var halfStep = stepSize / 2;
			for (var yy = 0; yy < w; yy += stepSize)
			{
				for (var xx = 0; xx < w; xx += stepSize)
				{
					var a = sample(xx, yy);
					var b = sample(xx + stepSize, yy);
					var c = sample(xx, yy + stepSize);
					var d = sample(xx + stepSize, yy + stepSize);
				
					var e = (a + b + c + d) / 4 + (prandom.NextFloat(1) * 2 - 1) * stepSize * scale;
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
				
					var H = (a + b + d + e) / 4 + (prandom.NextFloat(1) * 2 - 1) * stepSize * scale * 0.5;
					var g = (a + c + d + f) / 4 + (prandom.NextFloat(1) * 2 - 1) * stepSize * scale * 0.5;
				
					setSample(xx + halfStep, yy, H);
					setSample(xx, yy + halfStep, g);
				}
			}
			stepSize /= 2;
			scale *= (scaleMod + 0.8);
			scaleMod *= 0.3;
		}
	}
}