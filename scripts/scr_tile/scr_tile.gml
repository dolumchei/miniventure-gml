function singleton_Tile(vid) constructor
{
	prandom = new Random();
		
	static tiles = array_create(256, undefined);
		
	if (!is_undefined(vid))
	{
		self.id = vid;
		if (!is_undefined(tiles[id]))
			throw ($"Duplicate tile ids! {vid} {id}");
		tiles[id] = self;
	}
	
	static tileId = 0;
	static grass = new GrassTile(tileId++);
	static rock = new RockTile(tileId++);
	static water = new WaterTile(tileId++);
	static flower = new FlowerTile(tileId++);
	static tree = new TreeTile(tileId++);
	static dirt = new DirtTile(tileId++);
	static sand = new SandTile(tileId++);
	static cactus = new CactusTile(tileId++);
	static hole = new HoleTile(tileId++);
	static treeSapling = new SaplingTile(tileId++, grass, tree);
	static cactusSapling = new SaplingTile(tileId++, sand, cactus);
	static farmland = new FarmTile(tileId++);
	static wheat = new WheatTile(tileId++);
	static lava = new LavaTile(tileId++);
	static stairsDown = new StairsTile(tileId++, false);
	static stairsUp = new StairsTile(tileId++, true);
	static infiniteFall = new InfiniteFallTile(tileId++);
	static cloud = new CloudTile(tileId++);
	static hardRock = new HardRockTile(tileId++);
		
	static ironOre = new OreTile(tileId++, singleton_Resource().ironOre);
	static goldOre = new OreTile(tileId++, singleton_Resource().goldOre);
	static gemOre = new OreTile(tileId++, singleton_Resource().gem);
		
	static cloudCactus = new CloudCactusTile(tileId++);
		
	singleton_postInit = function()
	{
	
	}
		
	singleton_tick = function()
	{
		tickCount++;
	}
	
	static tickCount = 0;
	
	connectsToGrass = false;
	connectsToSand = false;
	connectsToLava = false;
	connectsToWater = false;
	
	render = function(screen, level, xx, yy) { }
	mayPass = function(level, xx, yy, e)
	{
		return true;
	}
	getLightRadius = function(level, xx, yy)
	{
		return 0;
	}
	hurt6 = function(level, xx, yy, source, dmg, attackDir) { }
	bumpedInto = function(level, xt, yt, entity) { }
	tick = function(level, xt, yt) { }
	steppedOn = function(level, xt, yt, entity) { }
	interact = function(level, xt, yt, player, item, attackDir)
	{
		return false;
	}
	connectsToLiquid = function()
	{
		return connectsToWater || connectsToLava;
	}
}