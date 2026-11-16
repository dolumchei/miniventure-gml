function singleton_Resource(name, sprite, color) constructor
{
	static wood = new singleton_Resource("Wood", 1 + 4 * 32, global.Color.get(-1, 200, 531, 430));
	static stone = new singleton_Resource("Stone", 2 + 4 * 32, global.Color.get(-1, 111, 333, 555));
	static flower = new PlantableResource("Flower", 0 + 4 * 32, global.Color.get(-1, 10, 444, 330), singleton_Tile.flower, singleton_Tile.grass);
	static acorn = new PlantableResource("Acorn", 3 + 4 * 32, global.Color.get(-1, 100, 531, 320), global.Tile.treeSapling, global.Tile.grass);
	static dirt = new PlantableResource("Dirt", 2 + 4 * 32, global.Color.get(-1, 100, 322, 432), global.Tile.dirt, [ global.Tile.hole, global.Tile.water, global.Tile.lava ]);
	static sand = new PlantableResource("Sand", 2 + 4 * 32, global.Color.get(-1, 110, 440, 550), global.Tile.sand, [ global.Tile.grass, global.Tile.dirt ]);
	static cactusFlower = new PlantableResource("Cactus", 4 + 4 * 32, global.Color.get(-1, 10, 40, 50), global.Tile.cactusSapling, global.Tile.sand);
	static seeds = new PlantableResource("Seeds", 5 + 4 * 32, global.Color.get(-1, 10, 40, 50), global.Tile.wheat, global.Tile.farmland);
	static wheat = new singleton_Resource("Wheat", 6 + 4 * 32, global.Color.get(-1, 110, 330, 550));
	static bread = new FoodResource("Bread", 8 + 4 * 32, global.Color.get(-1, 110, 330, 550), 2, 5);
	static apple = new FoodResource("Apple", 9 + 4 * 32, global.Color.get(-1, 100, 300, 500), 1, 5);

	static coal = new singleton_Resource("COAL", 10 + 4 * 32, global.Color.get(-1, 000, 111, 111));
	static ironOre = new singleton_Resource("I.ORE", 10 + 4 * 32, global.Color.get(-1, 100, 322, 544));
	static goldOre = new singleton_Resource("G.ORE", 10 + 4 * 32, global.Color.get(-1, 110, 440, 553));
	static ironIngot = new singleton_Resource("IRON", 11 + 4 * 32, global.Color.get(-1, 100, 322, 544));
	static goldIngot = new singleton_Resource("GOLD", 11 + 4 * 32, global.Color.get(-1, 110, 330, 553));

	static slime = new singleton_Resource("SLIME", 10 + 4 * 32, global.Color.get(-1, 10, 30, 50));
	static glass = new singleton_Resource("glass", 12 + 4 * 32, global.Color.get(-1, 555, 555, 555));
	static cloth = new singleton_Resource("cloth", 1 + 4 * 32, global.Color.get(-1, 25, 252, 141));
	static cloud = new PlantableResource("cloud", 2 + 4 * 32, global.Color.get(-1, 222, 555, 444), global.Tile.cloud, global.Tile.infiniteFall);
	static gem = new singleton_Resource("gem", 13 + 4 * 32, global.Color.get(-1, 101, 404, 545));

	self.name = name; 
	self.sprite = sprite; 
	self.color = color; 

	interactOn = function(tile, level, xt, yt, player, attackDir)
	{
		return false;
	}
}