function SaplingTile(vid, onType, growsTo) : singleton_Tile(vid, false) constructor
{
	self.onType = onType;
	self.growsTo = growsTo;
	connectsToSand = onType.connectsToSand;
	connectsToGrass = onType.connectsToGrass;
	connectsToWater = onType.connectsToWater;
	connectsToLava = onType.connectsToLava;
	
	static render = function(screen, level, xx, yy)
	{
		onType.render(screen, level, xx, yy);
		var col = global.Color.get(10, 40, 50, -1);
		screen.render(xx * 16 + 4, yy * 16 + 4, 11 + 3 * 32, col, 0);
	}
	static tick = function(level, xx, yy)
	{
		var age = level.getData(xx, yy) + 1;
		if (age > 100)
			level.setTile(xx, yy, growsTo, 0);
		else
			level.setData(xx, yy, age);
	}
	static hurt6 = function(level, xx, yy, source, dmg, attackDir)
	{
		level.setTile(xx, yy, onType, 0);
	}
}