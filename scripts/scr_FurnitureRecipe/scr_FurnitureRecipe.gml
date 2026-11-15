function FurnitureRecipe(clazz) : Recipe(["FurnitureItem", clazz]) constructor
{
	self.clazz = clazz;
	
	static craft = function(player)
	{
		player.inventory.add(0, new FurnitureItem(new clazz())); 
	}	
}