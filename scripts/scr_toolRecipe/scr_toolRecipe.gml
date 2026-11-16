function ToolRecipe(type, level) : Recipe(["ToolItem", type, level]) constructor
{
	self.type = type;
	self.level = level;
	
	craft = function(player)
	{
		player.inventory.add(0, new ToolItem(type, level)); 
	}
}
