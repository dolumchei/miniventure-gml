function PlantableResource(name, sprite, color, targetTile, sourceTiles) : singleton_Resource(name, sprite, color) constructor
{
	self.sourceTiles = sourceTiles;
	if (!is_array(self.sourceTiles))
		self.sourceTiles = [ sourceTiles ];
	self.targetTile = targetTile; 

	interactOn = function(tile, level, xt, yt, player, attackDir)
	{
		if (array_contains(sourceTiles, tile))
		{ 
			level.setTile(xt, yt, targetTile, 0); 
			return true;
		}
		return false;
	}
}
