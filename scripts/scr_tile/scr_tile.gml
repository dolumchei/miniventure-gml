function singleton_Tile(vid, __singleton = false) constructor
{
	if (!__singleton)
	{
		prandom = new Random();
		
		self.id = vid;
		if (!is_undefined(global.Tile.tiles[id]))
			throw ($"Duplicate tile ids! {vid} {id}");
		global.Tile.tiles[id] = self;
	}
	else
	{
		tiles = array_create(256, undefined);
		global.Tile = self;
		
		tileId = 0;
		grass = new GrassTile(tileId++);
		rock = new RockTile(tileId++);
		water = new WaterTile(tileId++);
		flower = new FlowerTile(tileId++);
		tree = new TreeTile(tileId++);
		dirt = new DirtTile(tileId++);
		sand = new SandTile(tileId++);
		cactus = new CactusTile(tileId++);
		hole = new HoleTile(tileId++);
		treeSapling = new SaplingTile(tileId++, grass, tree);
		cactusSapling = new SaplingTile(tileId++, sand, cactus);
		farmland = new FarmTile(tileId++);
		wheat = new WheatTile(tileId++);
		lava = new LavaTile(tileId++);
		stairsDown = new StairsTile(tileId++, false);
		stairsUp = new StairsTile(tileId++, true);
		infiniteFall = new InfiniteFallTile(tileId++);
		cloud = new CloudTile(tileId++);
		hardRock = new HardRockTile(tileId++);
		
		ironOre = undefined;
		goldOre = undefined;
		gemOre = undefined;
		
		cloudCactus = new CloudCactusTile(tileId++);
		
		static singleton_postInit = function()
		{
			ironOre = new OreTile(tileId++, global.Resource.ironOre);
			goldOre = new OreTile(tileId++, global.Resource.goldOre);
			gemOre = new OreTile(tileId++, global.Resource.gem);	
		}
		
		static singleton_tick = function()
		{
			tickCount++;
			for (var i = 0; i < array_length(tiles); i++)
			{
				if (tiles[i] != undefined)
					tiles[i].tickCount = tickCount;
			}
		}
	}
	
	tickCount = 0;
	
	connectsToGrass = false;
	connectsToSand = false;
	connectsToLava = false;
	connectsToWater = false;
	
	static render = function(screen, level, xx, yy) { }
	static mayPass = function(level, xx, yy, e)
	{
		return true;
	}
	static getLightRadius = function(level, xx, yy)
	{
		return 0;
	}
	static hurt6 = function(level, xx, yy, source, dmg, attackDir) { }
	static bumpedInto = function(level, xt, yt, entity) { }
	static tick = function(level, xt, yt) { }
	static steppedOn = function(level, xt, yt, entity) { }
	static interact = function(level, xt, yt, player, item, attackDir)
	{
		return false;
	}
	static connectsToLiquid = function()
	{
		return connectsToWater || connectsToLava;
	}
}